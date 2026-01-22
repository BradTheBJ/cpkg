const std = @import("std");

pub fn handleInstall(package: []const u8, packageName: []const u8) !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var externalDir = try std.fs.cwd().openDir(
        "cpkgExternal",
        .{ .access_sub_paths = true },
    );
    defer externalDir.close();

    try externalDir.makeDir(packageName);

    var packageDir = try externalDir.openDir(
        packageName,
        .{ .access_sub_paths = true },
    );
    defer packageDir.close();

    var child = std.process.Child.init(
        &[_][]const u8{
            "git",
            "clone",
            "--depth",
            "1",
            package,
            ".",
        },
        allocator,
    );

    child.cwd_dir = packageDir;

    const term = try child.spawnAndWait();
    if (term != .Exited or term.Exited != 0) {
        return error.GitCloneFailed;
    }
}

pub fn buildPackage(packageName: []const u8) !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var externalDir = try std.fs.cwd().openDir(
        "cpkgExternal",
        .{ .access_sub_paths = true },
    );
    defer externalDir.close();

    var packageDir = try externalDir.openDir(
        packageName,
        .{ .access_sub_paths = true },
    );
    defer packageDir.close();

    var configure = std.process.Child.init(
        &[_][]const u8{
            "cmake",
            "-S", ".",
            "-B", "build",
        },
        allocator,
    );
    configure.cwd_dir = packageDir;

    const cterm = try configure.spawnAndWait();
    if (cterm != .Exited or cterm.Exited != 0) {
        return error.CMakeConfigureFailed;
    }

    var build = std.process.Child.init(
        &[_][]const u8{
            "cmake",
            "--build", "build",
        },
        allocator,
    );
    build.cwd_dir = packageDir;

    const bterm = try build.spawnAndWait();
    if (bterm != .Exited or bterm.Exited != 0) {
        return error.CMakeBuildFailed;
    }
}



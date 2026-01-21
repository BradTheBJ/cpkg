const std = @import("std");
pub fn handleInstall(package: []const []const u8, packageName: []const []const u8) !void {
    const dir = try std.fs.cwd().openDir("cpkgExternal");
        
}

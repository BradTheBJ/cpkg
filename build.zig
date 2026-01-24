const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "cpkg",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/main.zig"),
            .target = target,
            .optimize = optimize,
            .link_libc = true,
        }),
    });

    // Add the C file
    exe.root_module.addCSourceFiles(.{
        .files = &[_][]const u8{ "src/methods/helpers/readLine.c" },
        .flags = &[_][]const u8{ "-std=c99", "-O3" },
    });

    // Add include paths separately
    exe.root_module.addIncludePath(b.path("src/methods/helpers")); // for readLine.h
    exe.root_module.addIncludePath(b.path("src"));                 // for other headers

    b.installArtifact(exe);
}


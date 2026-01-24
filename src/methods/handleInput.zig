const std = @import("std");
const  installPackage = @import("installPackage.zig");
const cpkgInit = @import("cpkgInit.zig");
const buildPackage = @import("buildPackage.zig");

//TODO: Refactor the input system so its easier to expand

pub fn handleInput(args: []const []const u8) !void {
    if (args.len < 2) {
        std.debug.print("Not enough arguments\n", .{});
        return;
    }

    if (std.mem.eql(u8, args[1], "init")) {
        try cpkgInit.cpkgInit();
    }
    if (std.mem.eql(u8, args[1], "install")) {
        try installPackage.installPackage(args[2], args[3]);
        try buildPackage.buildPackage(args[3]);
    }
}

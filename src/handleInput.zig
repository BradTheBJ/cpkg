const std = @import("std");
const handleInstall = @import("handleInstall.zig");
const cpkgInit = @import("cpkgInit.zig");
pub fn handleInput(args: []const []const u8) !void {
    if (args.len < 2) {
        std.debug.print("Not enough arguments\n", .{});
        return;
    }

    if (std.mem.eql(u8, args[1], "init")) {
        try cpkgInit.cpkgInit();
    }
    if (std.mem.eql(u8, args[1], "install")) {
        try handleInstall.handleInstall(args[2], args[3]);
    }
}

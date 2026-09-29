const std = @import("std");
const rl = @import("raylib");
const Camera = @import("Camera.zig");

pub fn main() !void {
    rl.SetTraceLogLevel(rl.LOG_WARNING);
    rl.SetConfigFlags(rl.FLAG_WINDOW_RESIZABLE | rl.FLAG_MSAA_4X_HINT);
    rl.InitWindow(1500, 900, "Zenon");
    defer rl.CloseWindow();

    var camera: Camera = .init(@splat(0));

    while (!rl.WindowShouldClose()) {
        const dt = rl.GetFrameTime();

        camera.update(dt);

        rl.BeginDrawing();
        defer rl.EndDrawing();

        rl.ClearBackground(rl.PINK);

        rl.BeginMode2D(camera.toRaylib());
        defer rl.EndMode2D();

        rl.DrawRectangleV(
            .{ .x = -100.0, .y = -0.5 },
            .{ .x = 200.0, .y = 0.5 },
            rl.LIME,
        );

        rl.DrawCircleV(
            .{
                .x = 0.0,
                .y = -0.5,
            },
            0.25,
            rl.RED,
        );
    }
}

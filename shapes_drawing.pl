% Define the window with a title and size
window(title('Draw Shapes'), size(400, 300)).

% Function to handle mouse clicks, drawing a shape centered at the click point
win_func(mouse_click(X, Y)) :-
    write('Mouse clicked at ('), write(X), write(', '), write(Y), write(')'), nl,
    Radius = 20, % For circle
    SideLength = 40, % For square
    Width = 60, Height = 40, % For rectangle
    draw_circle(X, Y, Radius, rgb(255, 0, 0)), % Draw a circle with radius 20
    draw_square(X, Y, SideLength, rgb(0, 255, 0)), % Draw a square with side length 40
    draw_rectangle(X, Y, Width, Height, rgb(0, 0, 255)), % Draw a rectangle
    write('Shapes drawn at ('), write(X), write(', '), write(Y), write(')'), nl, !.

% Fallback function for mouse clicks if the previous one fails
win_func(mouse_click(_, _)) :-
    write('Cannot draw the shapes!'), nl.

% Function to draw a circle
draw_circle(CX, CY, Radius, Color) :-
    write('Drawing circle with center ('), write(CX), write(', '), write(CY), 
    write(') and radius '), write(Radius), write(' with color '), write(Color), nl,
    generate_circle_points(CX, CY, Radius, Points),
    draw_points(Points, Color).

% Function to draw a square
draw_square(CX, CY, SideLength, Color) :-
    HalfSide is SideLength // 2,
    X1 is CX - HalfSide, Y1 is CY - HalfSide, % Top-left corner
    X2 is CX + HalfSide, Y2 is CY + HalfSide, % Bottom-right corner
    write('Drawing square with top-left ('), write(X1), write(', '), write(Y1),
    write(') and bottom-right ('), write(X2), write(', '), write(Y2), write(')'), nl,
    draw_rectangle(CX, CY, SideLength, SideLength, Color). % Square is a special case of a rectangle

% Function to draw a rectangle
draw_rectangle(CX, CY, Width, Height, Color) :-
    HalfWidth is Width // 2, HalfHeight is Height // 2,
    X1 is CX - HalfWidth, Y1 is CY - HalfHeight, % Top-left corner
    X2 is CX + HalfWidth, Y2 is CY + HalfHeight, % Bottom-right corner
    write('Drawing rectangle with top-left ('), write(X1), write(', '), write(Y1),
    write(') and bottom-right ('), write(X2), write(', '), write(Y2), write(')'), nl,
    % Draw the four sides of the rectangle
    draw_line(X1, Y1, X2, Y1, Color), % Top side
    draw_line(X1, Y2, X2, Y2, Color), % Bottom side
    draw_line(X1, Y1, X1, Y2, Color), % Left side
    draw_line(X2, Y1, X2, Y2, Color). % Right side

% Helper function to draw lines between two points
draw_line(X1, Y1, X2, Y2, Color) :-
    write('Drawing line from ('), write(X1), write(', '), write(Y1),
    write(') to ('), write(X2), write(', '), write(Y2), write(') with color '), write(Color), nl.

% Predicate to generate all points on the circle
generate_circle_points(CX, CY, Radius, Points) :-
    generate_circle_points(CX, CY, Radius, 0, [], Points).

generate_circle_points(_, _, _, 360, Acc, Acc) :- !.
generate_circle_points(CX, CY, Radius, Angle, Acc, Points) :-
    Radian is Angle * pi / 180,
    TempX is CX + Radius * cos(Radian),
    TempY is CY + Radius * sin(Radian),
    X is round(TempX),
    Y is round(TempY),
    NextAngle is Angle + 1,
    generate_circle_points(CX, CY, Radius, NextAngle, [(X, Y) | Acc], Points).

% Helper function to draw points
draw_points([], _).
draw_points([(X, Y) | Rest], Color) :-
    draw_point(X, Y, Color),
    draw_points(Rest, Color).

% Function to draw a point (placeholder, replace with actual drawing logic)
draw_point(X, Y, Color) :-
    % Placeholder for the actual drawing logic
    % Simulating the drawing by printing the coordinates
    write('Drawing point at ('), write(X), write(', '), write(Y), write(') with color '), write(Color), nl.

% Start the window
:- window.

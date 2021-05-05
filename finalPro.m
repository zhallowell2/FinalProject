function [] = finalPro()
global gui 
h = helpdlg('Inputs must be in the form ax^2 + bx + c = d and input "a" must be non-zero.','Instructions');
uiwait(h)
% Gives general instructions for program use
gui.coPrompt1 = {'What is the coefficient "a" in the expression ax^2 + bx + c = d?'};
gui.inputCellA = inputdlg(gui.coPrompt1, 'Coefficient "a"', 1);
gui.inputCellA = cellfun(@str2num, gui.inputCellA);
gui.coPrompt2 = {'What is the coefficient "b" in the expression ax^2 + bx + c = d?'};
gui.inputCellB = inputdlg(gui.coPrompt2, 'Coefficient "b"', 1);
gui.inputCellB = cellfun(@str2num, gui.inputCellB);
gui.coPrompt3 = {'What is the coefficient "c" in the expression ax^2 + bx + c = d?'};
gui.inputCellC = inputdlg(gui.coPrompt3, 'Coefficient "c"', 1);
gui.inputCellC = cellfun(@str2num, gui.inputCellC);
gui.coPrompt4 = {'What is the coefficient "d" in the expression ax^2 + bx + c = d?'};
gui.inputCellD = inputdlg(gui.coPrompt4, 'Coefficient "d"', 1);
gui.inputCellD = cellfun(@str2num, gui.inputCellD);
% Lines 5-16 prompt the user to enter coefficients in dialog boxes, and
% converts the returned cell to a number for further use
gui.eqn = 'ax^2 + bx + c = d';
gui.eqnComp = sprintf('Your equation is: %d*x^2 + %d*x + %d = %d', gui.inputCellA, gui.inputCellB, gui.inputCellC, gui.inputCellD);
% Gets the updated equation with user inputs
gui.fig = figure('numbertitle','off','name','Quadratic Equation Solver');
set(gca,'Position',[0.1, 0.3, 0.8 0.6]);
% Places a coordinate axis in the middle of the newly opened figure titled
% Quadratic Equation Solver
gui.solveButton = uicontrol('Style', 'pushbutton', 'String', 'Solve Equation', ...
    'Units', 'normalized', 'Position', [0.2 0.1 0.2 0.1], ...
    'Callback', {@solveEqn});
% Pushbutton that solves for the roots of the given quadratic (if they are
% real)
gui.plotButton = uicontrol('Style', 'pushbutton', 'String', 'Plot Graphs', ...
    'Units', 'normalized', 'Position', [0.6 0.1 0.2 0.1], ...
    'Callback', {@plotEqn});
% Plots the function and its first two derivatives 
gui.eqnDisplay = uicontrol('style', 'text', 'string', ...
    gui.eqnComp, ...
    'units','normalized', ...
    'position', [0.243 0.93 0.5 0.04], 'horizontalalignment', 'center', 'FontSize', 10);
% Text control to display updated equation with user inputs
gui.eqnTog = uicontrol('Style','togglebutton',...
            'Units','normalized',...
            'Position',[0.7 0.91 0.15 0.08],...
            'String','Integrate',...
            'Callback',@togEqn);  
% Toggle button that opens a new window for the integral function        
gui.closeButton = uicontrol('Style','togglebutton',...
            'Units','normalized',...
            'Position',[0.01 0.93 0.1 0.06],...
            'String','Escape',...
            'Callback',@closeButton); 
% Closes all ui figure windown        
end
function [] = plotEqn(~,~,~,~)
global gui
hold on
x = -100:.1:100;
y =(gui.inputCellA)*x.^2 + (gui.inputCellB)*x + (gui.inputCellC - gui.inputCellD); 
% Gets orignal equation 
a = -100:.1:100;
b = 2*(gui.inputCellA)*x + (gui.inputCellB);
% Finds the first derivative
d = 2*(gui.inputCellA)*1;
% Finds the second derivative 
xlim([-40 40]);
ylim([-80 80]);
% Sets plot limits
xL = xlim;
yL = ylim;
tL = d;
plot(x,y, 'b-')
plot(a,b, 'r-')
yline(tL)
% Plots function and first two derivatives
line([0 0], yL); 
line(xL, [0 0]);
% Plots x and y axis
hold off
legend('Function','First Derivative','Second Derivative')
end
function [x1,x2] = solveEqn(~,~,~,~)
    global gui
    if gui.inputCellA == isempty(gui.inputCellA)
        errordlg('Must input a value!','ERROR!')
    end
    a = gui.inputCellA;
 
    b = gui.inputCellB;
    
    c = gui.inputCellC;
    
    d = gui.inputCellD;
% Converts inputs into variables and displays an error if no a coefficient
% is inputed 
    x = (b^2)-(4*(a*(c-d)));
% Determines the type of solution based on value of x
if x < 0      
    
    msgbox(sprintf("The equation does not have a real root."));
    x1 = 'DNE';
    x2 = 'DNE';
    return
% If x < 0 the equation does not have real roots    
elseif (x == 0)
   x1 = (-b/(2*(a))); 
   x2 = 'DNE';
   msgbox(sprintf('Root is %d mult 2',x1))
% Solves for a repeated root if x = 0   
else
   
   x1 = ((-b+sqrt(x))/(2*(a)));
   x2 = ((-b-sqrt(x))/(2*(a)));
   
   msgbox(sprintf('Roots are %d and %d',x1,x2))
% Solves for the two real roots under normal conditions    
end
end
function [] = togEqn(~,~,~,~)
global gui
hold on
xlim([-100 100])
ylim([-100 100])
a = gui.inputCellA;
b = gui.inputCellB;
c = gui.inputCellC;
d = gui.inputCellD;
j = -10:.1:10;
i = (1/3)*a*j.^3 + (1/2)*b*j.^2 + (c-d)*j;
% Solves for the integral
x = -10:.1:10;
y = a*x.^2 + b*x + (c-d);
% Establishes original equation 
figure('NumberTitle', 'off', 'Name', 'Integral');

plot(j,i, 'r-', x,y, 'b-')
yline(0)
xline(0)
% Plots the integral and the original equation as well as the x and y axes
hold off
legend('Integral','Original Function')
msgbox(sprintf('The integral is: (%d/3)*x^3 + (%d/2)*x^2 + %d*x + C = 0', a, b, (c-d)));

end
function [] = closeButton(~,~,~,~)
closereq()
% Closes all gui windows
end
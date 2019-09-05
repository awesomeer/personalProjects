#include <GL/glut.h>
#include <GL/gl.h>
#include <GL/glu.h>
#include <GL/glew.h>
#include <GLFW/glfw3.h>
#include <cuda_gl_interop.h>
#include <iostream>
using namespace std;


int fov;
void render(void){
    glClear(GL_DEPTH_BUFFER_BIT | GL_COLOR_BUFFER_BIT);
    glBegin(GL_TRIANGLES);
        glVertex3f(1, 0, 0);
        glVertex3f(0, 1, 0);
        glVertex3f(-1, 0, 0);
    glEnd();

    glutSwapBuffers();

    cout << "render" << endl;
}

void view(int w, int h){
    (h == 0) ? h = 1 : h=h;
    
    float ratio = (1.0 * (float) w) / (float) h;

    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    glViewport(0,0,w,h);
    gluPerspective(fov, ratio, 45, 100);
    glMatrixMode(GL_MODELVIEW);
}

void idle(void){
    cout << "idle" << endl;
}
int main(int argc, char ** argv){
    fov = 0;
    glutInit(&argc, argv);
    glutInitWindowPosition(100,100);
    glutInitWindowSize(800,640);
    glutInitDisplayMode(GLUT_DEPTH | GLUT_RGBA | GLUT_DOUBLE);
    glutCreateWindow("awd");
    
    glutDisplayFunc(render);
    glutReshapeFunc(view);
    //glutIdleFunc(render);
    glutMainLoop();

    cout << glGetString(GL_VERSION) << endl;
}
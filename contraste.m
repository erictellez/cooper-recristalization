%Programa para convertir las imagenes del microscopio electr�nico a
%im�genes binarias con un color el fondo y el otro colo el grano
%El programa tambien deberia calcular el �rea que tienen los granos para
%poder evaluar el crecimiento de grano en funci�n del tiempo.
%Este es el primer programa que hice para procesar las im�genes. Noviiembre
%2011

archivo = input('Escribe el nombre del archivo: ', 's');  %pide el nombre del archivo
fotocolor=imread(archivo);  %Carga el archivo
foto = .2989*fotocolor(:,:,1)+0.5870*fotocolor(:,:,2)+.1140*fotocolor(:,:,3); %Instrucci�n para convertir la foto en color a una en escala de grises
figure; colormap(gray(256)); image(foto)  %Para graficar y mirar las fotos

%Ahora se hace un lato contraste para reconocer mejor las formas de la
%imagen
contrastefoto = adapthisteq(foto,'NumTiles',[3 3],'ClipLimit',0.001);
contrastefoto = imadjust(contrastefoto);
figure;imshow(contrastefoto)

%Aqui se convierte esta imagen a binaria, es decir, simplemente blanco y
%negro
%level = graythresh(contrastefoto);
BW = im2bw(contrastefoto, 0.55);
figure; imshow(BW)

%Esta parte es para calcular el �rea en blanco del archivo binario
%Area=bwarea(BW);  %Si le quitamos el ; a esta instrucci�n  entonces podemos ver la cantidad de �rea blanca de esta fotograf�a

%Esta instrucci�n es para normalizar el tama�o del �rea tomada con respecto
%de la fotografia, pues podr�a ser que las fotograf�as fueran de tama�os
%diferentes unas de otras
Areatotal=length(BW(:,1))*length(BW(:,2)); %Primero se obtiene el �rea total de la figura
Coeff=Area/Areatotal;  %Es la proporci�n de puntos blancos en la foto

%Finalmente, aqu� se va a escribir en el archivo recristal.dat para que se pueda leer
%en excel de ser necesario
file_id = fopen('recristal.dat', 'a'); %Esta instrucción es para abrir un archivo y escribir en el.
fprintf(file_id,'%i ',Coeff);   %Para imprimir el �rea generada de esta fotograf�a
fprintf(file_id,'\n');   %inserta una linea para escribir en la siguiente
fclose(file_id); %Cierra el archivo

%Fin del programa
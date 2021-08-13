%Programa para convertir las imagenes del microscopio electrónico a
%imágenes binarias con un color el fondo y el otro colo el grano
%El programa tambien deberia calcular el área que tienen los granos para
%poder evaluar el crecimiento de grano en función del tiempo.
%Este es el primer programa que hice para procesar las imágenes. Noviiembre
%2011

archivo = input('Escribe el nombre del archivo: ', 's');  %pide el nombre del archivo
fotocolor=imread(archivo);  %Carga el archivo
foto = .2989*fotocolor(:,:,1)+0.5870*fotocolor(:,:,2)+.1140*fotocolor(:,:,3); %Instrucción para convertir la foto en color a una en escala de grises
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

%Esta parte es para calcular el área en blanco del archivo binario
%Area=bwarea(BW);  %Si le quitamos el ; a esta instrucción  entonces podemos ver la cantidad de área blanca de esta fotografía

%Esta instrucción es para normalizar el tamaño del área tomada con respecto
%de la fotografia, pues podría ser que las fotografìas fueran de tamaños
%diferentes unas de otras
Areatotal=length(BW(:,1))*length(BW(:,2)); %Primero se obtiene el área total de la figura
Coeff=Area/Areatotal;  %Es la proporción de puntos blancos en la foto

%Finalmente, aquí se va a escribir en el archivo recristal.dat para que se pueda leer
%en excel de ser necesario
file_id = fopen('recristal.dat', 'a'); %Esta instrucciÃ³n es para abrir un archivo y escribir en el.
fprintf(file_id,'%i ',Coeff);   %Para imprimir el área generada de esta fotografía
fprintf(file_id,'\n');   %inserta una linea para escribir en la siguiente
fclose(file_id); %Cierra el archivo

%Fin del programa
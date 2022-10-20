const myObj = {
	nestedObj1 : {
		price : 100,
		quantity : 5
	},
	nestedObj2 : {
		price : 150,
		quantity : 5
	}
};
// cómo leer los datos de un json:
myObj.nestedObj2.quantity
// conditions:
//1
if ('1 text' === 'other text') {
	console.log('the starts are beautiful')
} else {console.log('they are not')};
//2
if ('1 text' === 'other text') {
	console.log('the starts are beautiful')
} else if (1 == '1'){console.log('elif conditions works like that, identation doesnt matter')};
// 
const colors = ['red', 'blue','brown','purple'];
randomIndex = MATH.floor(MATH.random() * colors.length);

const randomColor = colors[randomIndex];
if (randomColor === 'red'){
	console.log('es rojo')
}
//loops
X = [12,12354,342,32467,87689,345643,11235];
for (let i = 0; i < X.length; i++) {
	console.log(X[i])
}
// functions
function myFunction() {
	console.log('1st function')
};
function myFunction2(param1, param2) {
	console.log('1st function');
	console.log(param1);
	console.log(param2);
};
// arrow functions, se usan mucho pero no se muy bien por qué, algo del scope
const arrowFunction = () => {
	console.log(19+3)
};
// some methods
str = 'hello';
paso1 = str.split("");
paso2 = paso1.reverse(); 
paso3 = paso2.join(''); //si no une con ',' 
// regex
const emailValidatorEmail = new RegExp ('^.+@.+\.[(es)(com)]{1}$');
const regex2 = /[a-z]+/
		//flags: /i (case-insensitie); /g (global); /m multiline mode (npi); /s allows . to be equal /n; /u unicode; /y sticky mode(search the exact position)
//bucles sobre JSONS:
const externalData =  [
{
	title: 'how to code     ',
	author: '  zach'
},
{
	title: 'elk ',
	author : '  zach'
}
];
for  (let i = 0; i < externalData.length; i++) {
	const currentTitle = externalData[i].title;
	const currentAuthor = externalData[i].author;
	externalData[i].title = currentTitle.trim();
	externalData[i].author = currentAuthor.trim();
}


/* sigo por aquí https://youtu.be/zJSY8tbf_ys?t=27638 ; enlace interesante https://javascript.info/regexp-introduction

*/
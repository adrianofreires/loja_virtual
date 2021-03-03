import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_clean_architecture/core/usecases/usecase.dart';
import 'package:tdd_clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd_clean_architecture/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_clean_architecture/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  GetRandomNumberTrivia usecase;
  MockNumberTriviaRepository mockNumberTriviaRepository;
  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetRandomNumberTrivia(mockNumberTriviaRepository);
  });

  final tNumberTrivia = NumberTrivia(number: 1, text: 'test');

  test('deverá pegar a curiosidade do repositorio', () async {

    // Implementação "em tempo real" do Repositório usando o pacote Mockito.
    // Quando getConcreteNumberTrivia é chamado com qualquer argumento, sempre responda com
    // o Right de Either contendo um objeto NumberTrivia de teste.
    when(mockNumberTriviaRepository.getRandomNumberTrivia())
        .thenAnswer((_) async => Right(tNumberTrivia));

    // A fase de "ação" do teste. Chame o método ainda não existente.
    final result = await usecase(NoParams());
    
    // useCase deve simplesmente retornar tudo o que foi retornado do Repositório
    expect(result, Right(tNumberTrivia));

    // Verifique se o método foi chamado no Repositório
    verify(mockNumberTriviaRepository.getRandomNumberTrivia());

    // Apenas o método acima deve ser chamado e nada mais.
    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}

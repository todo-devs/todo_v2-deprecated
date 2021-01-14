import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo/core/classes/classes.dart';
import 'package:todo/core/services/services.dart';
import 'package:todo/features/ussd_codes/domain/entities/entities.dart';
import 'package:todo/features/ussd_codes/domain/repositories/repositories.dart';
import 'package:todo/features/ussd_codes/domain/services/services.dart';

class MockUssdCodesRepository extends Mock implements IUssdCodesRepository {}

void main() {
  GetLocalUssdCodes service;
  MockUssdCodesRepository mockUssdCodesRepository;

  setUp(() {
    mockUssdCodesRepository = MockUssdCodesRepository();
    service = GetLocalUssdCodes(repository: mockUssdCodesRepository);
  });

  final tData = [
    UssdCode(
      name: 'Test name',
      description: 'Test description',
      icon: 'icon_test',
      type: 'test type',
      code: '123',
      fields: [],
    )
  ];

  test('Should get ussd code list from repository', () async {
    final repositoryResult = Result(isOk: true, data: tData);

    // arrange
    when(mockUssdCodesRepository.getLocalUssdCodes())
        .thenAnswer((_) async => repositoryResult);

    // act
    final result = await service(NoParams());

    // assert
    expect(result, repositoryResult);
    verify(mockUssdCodesRepository.getLocalUssdCodes());
    verifyNoMoreInteractions(mockUssdCodesRepository);
  });
}

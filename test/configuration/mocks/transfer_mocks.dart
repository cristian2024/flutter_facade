import 'package:flutter_facade/application/transfer_facade.dart';
import 'package:flutter_facade/domain/account_type.dart';
import 'package:flutter_facade/domain/models/account_model.dart';
import 'package:flutter_facade/domain/repositoy/transfer_repository.dart';
import 'package:flutter_facade/domain/services/analytics_service.dart';
import 'package:flutter_facade/domain/services/security_service.dart';
import 'package:flutter_facade/ui/provider/accounts/accounts_cubit.dart';
import 'package:flutter_facade/ui/provider/transfer/transfer_cubit.dart';
import 'package:mocktail/mocktail.dart';

import 'package:bloc_test/bloc_test.dart';

class TransferMockRepository extends Mock implements TransferRepository {}

class SecurityMockService extends Mock implements SecurityService {}

class AnalyticsMockService extends Mock implements AnalyticsService {}

//fakes
class AccountFake extends Fake implements AccountModel {}

class MockAccountsCubit extends MockCubit<AccountsState>
    implements AccountsCubit {}

class MockTransferCubit extends MockCubit<TransferState>
    implements TransferCubit {}

class MockTransferFacade extends Mock implements TransferFacade {}


final List<AccountModel> fakeAccounts = [
  AccountModel(
    id: "12341234",
    type: AccountType.ahorros,
    balance: 20000,
  ),
  AccountModel(
    id: "12341234",
    type: AccountType.ahorros,
    balance: 100000,
  ),
  AccountModel(
    id: "*errorTransfiriendo",
    type: AccountType.corriente,
    balance: 30000,
  ),
  AccountModel(
    id: "*noExiste",
    type: AccountType.corriente,
    balance: 30000,
  ),
];

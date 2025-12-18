import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facade/application/injection.dart';
import 'package:flutter_facade/domain/models/user_model.dart';
import 'package:flutter_facade/ui/provider/accounts/accounts_cubit.dart';
import 'package:flutter_facade/ui/provider/transfer/transfer_cubit.dart';

import 'package:flutter_facade/ui/widgets/transfer_body.dart';

class TransferScreen extends StatelessWidget {
  const TransferScreen({
    super.key,
    required this.onTransferSuccess,
  });

  final VoidCallback onTransferSuccess;

  static const String routeName = 'transfer_screen';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TransferCubit(readIt()),
        ),
        BlocProvider(
          create: (context) => AccountsCubit(
            UserModel(name: 'Pragma worker', id: '12341234'),
            useCase: readIt(),
          )..getAccountsOfUser(),
          lazy: false,
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16),
            child:  TransferBody(
              onTransferSuccess: onTransferSuccess,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:momentum_track/core/bloc/app_settings/app_settings_cubit.dart';
import 'package:momentum_track/core/data/enums/language_details.dart';
import 'package:momentum_track/core/l10n/generated/l10n.dart';
import 'package:momentum_track/core/widgets/app_elevated_button.dart';

class ChangeLanguageDialogBox extends StatefulWidget {
  const ChangeLanguageDialogBox({super.key});

  @override
  State<ChangeLanguageDialogBox> createState() =>
      _ChangeLanguageDialogBoxState();
}

class _ChangeLanguageDialogBoxState extends State<ChangeLanguageDialogBox> {
  late LanguageDetails language;

  @override
  void initState() {
    super.initState();

    language = context.read<AppSettingsCubit>().state.languageDetails;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSettingsCubit, AppSettingsState>(
      builder: (context, state) {
        final List<LanguageDetails> languages = [
          LanguageDetails.english,
          LanguageDetails.persian,
        ];

        return SimpleDialog(
          title: Text('Select Language'),
          contentPadding: const EdgeInsets.all(16),

          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              child: DropdownButton<LanguageDetails>(
                // hint: Text(S.current.fieldHint_chooseProject),
                borderRadius: BorderRadius.circular(16),
                isExpanded: true,
                elevation: 1,
                padding: EdgeInsets.symmetric(horizontal: 12),
                underline: SizedBox.shrink(),
                value: language,
                items: languages.map((e) {
                  return DropdownMenuItem<LanguageDetails>(
                    value: e,
                    child: Text(e.title),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    language = value;
                    setState(() {});
                  }
                },
              ),
            ),
            Gap(16),

            Row(
              children: [
                Expanded(
                  child: AppElevatedButton(
                    onPressed: () {
                      context
                        ..read<AppSettingsCubit>().changeLanguage(language)
                        ..pop();
                    },
                    title: S.current.button_submit,
                  ),
                ),
                Gap(8),
                TextButton(
                  onPressed: () => context.pop(),
                  child: Text(S.current.button_cancel),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

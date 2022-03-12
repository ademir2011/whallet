import 'package:flutter/material.dart';
import 'package:whallet/src/portifolio/stores/cripto_store.dart';
import 'package:whallet/src/widgets/elevated_button_widget.dart';
import 'package:whallet/src/widgets/label_symbol_dialog_widget.dart';
import 'package:whallet/src/widgets/outlined_button_widget.dart';
import 'package:whallet/src/widgets/textformfield_widget.dart';

class CriptoDialogWidget extends StatefulWidget {
  final String title;
  final String subtitle;
  final CriptoStore criptoStore;

  const CriptoDialogWidget({
    Key? key,
    required this.criptoStore,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  State<CriptoDialogWidget> createState() => _CriptoDialogWidgetState();
}

class _CriptoDialogWidgetState extends State<CriptoDialogWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.criptoStore.searchCrypto();
    widget.criptoStore.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    widget.criptoStore.disposeAll();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: Text(widget.title),
      content: SizedBox(
        height: 450,
        child: Column(
          children: [
            Text(
              widget.subtitle,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            TextFormFieldWidget(
              hintText: 'Buscar Cripto',
              icon: const Icon(Icons.abc),
              validator: widget.criptoStore.criptoSymbolValidate,
              controller: widget.criptoStore.criptoSymbolController,
              focusNode: widget.criptoStore.criptoSymbolFocus,
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: widget.criptoStore.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 15,
                        childAspectRatio: 4 / 2,
                      ),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return LabelSymbolDialogWidget(
                          symbleName: 'BTC',
                          selected: false,
                          onTap: () {},
                        );
                      },
                    ),
            ),
            const SizedBox(height: 10),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlineButtonWidget(onPressed: () => Navigator.of(context).pop(), title: 'Fechar'),
                ElevatedButtonWidget(onPressed: () {}, title: 'Adicionar'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

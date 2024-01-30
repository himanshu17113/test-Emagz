import 'package:flutter/material.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) => Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 3),
              Padding(
                padding: const EdgeInsets.only(left: 93),
                child: Text(
                  "Basic Ad",
                  style: theme.textTheme.titleMedium,
                ),
              ),
              const SizedBox(height: 2),
              Container(
                width: 168,
                margin: const EdgeInsets.only(left: 49),
                child: Text(
                  "For companies that need to manage work happening across multiple teams.",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall!.copyWith(
                    height: 1.50,
                  ),
                ),
              ),
              const SizedBox(height: 56),
              Container(
                margin: const EdgeInsets.only(
                  left: 11,
                  right: 1,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 20,
                        bottom: 18,
                      ),
                      child: Text(
                        "Grow your business, easily.",
                        //  style: CustomTextStyles.outfitBlue800,
                      ),
                    ),
                    Container(
                      width: 32,
                      margin: const EdgeInsets.only(
                        left: 11,
                        top: 17,
                        bottom: 17,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 2,
                      ),
                      child: const Text(
                        "Get Started",
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 49),
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.euro),
                    Text("50", style: theme.textTheme.headlineMedium),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 5,
                        top: 10,
                        bottom: 11,
                      ),
                      child: Text(
                        "/ month",
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 23),
              Padding(
                padding: const EdgeInsets.only(right: 73),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 11,
                        bottom: 5,
                      ),
                      child: Text(
                        "17 days Left",
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                    // CustomElevatedButton(
                    //   width: 136 ,
                    //   text: "Expire on 12 Nov 2023",
                    //   margin: const EdgeInsets.only(left: 22 ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

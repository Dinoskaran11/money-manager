import 'package:expensetracker/controllers/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {

  int? amount;
  String note = "Some expense";
  String type = "Income";
  DateTime selectedDate = DateTime.now();

  List<String> months =[
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  Future<void> _selectDate(BuildContext context) async{
    final DateTime? picker = await showDatePicker(
      
      context: context, 
      initialDate: selectedDate,
      firstDate: DateTime(2024,11), 
      lastDate: DateTime(2100,01));

      if (picker != null && picker != selectedDate) {
        setState(() {
          selectedDate = picker;
        });
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      
      body: ListView(
        padding: EdgeInsets.all(12),
        children: [
          SizedBox(height: 20,),

          Text(
            "Add Transaction",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700
            ),
          ),

          SizedBox(height: 20,),

          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF15049b),
                  borderRadius: BorderRadius.circular(16)
                ),
                padding: EdgeInsets.all(12),
                child: Icon(Icons.attach_money,
                size: 24,
                color: Colors.white,
                )),

                SizedBox(width: 12,),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "0",
                    border: InputBorder.none,
                
                  ),
                  style: TextStyle(
                    fontSize: 24
                  ),
                  onChanged: (val){
                    try {
                      amount = int.parse(val);
                    } catch (e) {
                      
                    }
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),

          SizedBox(height: 20,),

          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF15049b),
                  borderRadius: BorderRadius.circular(16)
                ),
                padding: EdgeInsets.all(12),
                child: Icon(Icons.description,
                size: 24,
                color: Colors.white,
                )),

                SizedBox(width: 12,),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Note on transaction",
                    border: InputBorder.none,
                
                  ),
                  style: TextStyle(
                    fontSize: 24
                  ),
                  onChanged: (val){
                    note = val;
                  } ,
                ),
              ),
            ],
          ),

          SizedBox(height: 20,),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF15049b),
                  borderRadius: BorderRadius.circular(16)
                ),
                padding: EdgeInsets.all(12),
                child: Icon(Icons.moving_sharp,
                size: 24,
                color: Colors.white,
                )),

                SizedBox(width: 12,),

                ChoiceChip(
                 
                  label: 
                  Text("Income",
                  style: TextStyle(
                    fontSize: 16,
                    color: type == "Income" ? Colors.white: Colors.black
                  ),
                  ), 
                selected: type == "Income" ? true: false,
                selectedColor: Color(0xFF15049b),
                onSelected: (val){
                  if (val) {
                    setState(() {
                      type = "Income";
                    });
                  }
                },
                ),

                SizedBox(width: 12,),

               ChoiceChip(
                 
                  label: 
                  Text("Expense",
                  style: TextStyle(
                    fontSize: 16,
                    color: type == "Expense" ? Colors.white: Colors.black
                  ),
                  ), 
                selected: type == "Expense" ? true: false,
                selectedColor: Color(0xFF15049b),
                onSelected: (val){
                  if (val) {
                    setState(() {
                      type = "Expense";
                    });
                  }
                },
                ),
            ],
          ),

          SizedBox(height: 20,),

          SizedBox(
            height: 50,
            child: TextButton(onPressed: (){
              _selectDate(context);
            }, 
            style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.zero)),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF15049b),
                    borderRadius: BorderRadius.circular(16)
                  ),
                  padding: EdgeInsets.all(12),
                  child: Icon(Icons.date_range,
                  size: 24,
                  color: Colors.white,),
                ),
                SizedBox(width: 12,),
                Text("${selectedDate.day} ${months[selectedDate.month-2]}",
                style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600
            ),
            ),
              ],
            )),
          ),

          SizedBox(height: 20,),

          SizedBox(
            height: 50,
            child: ElevatedButton(onPressed: () async{
              if (amount != null && note.isNotEmpty) {
                DbHelper dbHelper = DbHelper();
                await dbHelper.addData(amount!, selectedDate, note, type);
                Navigator.of(context).pop();
              }else{
                print("Not all values provided");
              }
            }, 
            
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Color(0xFF15049b)),
              
            ),
            child: Text("Add",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600
            ),
            ),),
          )
        ],
      )
    );
  }
}
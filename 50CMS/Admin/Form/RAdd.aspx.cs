using System;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Linq;


    public partial class RAdd : AdminBase
    {
        public int _Id=0;
        public int textnum = 0;
        public int Mtextnum = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            Response.CacheControl = "no-cache";
            if (!string.IsNullOrEmpty(Request.Params["ID"]))
            {
                _Id = int.Parse(HttpContext.Current.Request.QueryString["ID"]);
            }
            if (!Page.IsPostBack)
            {
                Entities mydb = new Entities();
                {

                    L_RForm fmRe = mydb.L_RForm.First(p => p.FrID == _Id);
                    this.Labtitle.Text = fmRe.FrName;

                    if (fmRe.FrReOk == 0)
                        CheckBox1.Checked = true;


                    string a = fmRe.Fr1;
                    string av = fmRe.Fr2;

                    if (a.Length > 0)
                    {
                        a = a.Substring(0, a.Length - 1);
                        av = av.Substring(0, av.Length - 1);
                        string[] sArray = a.Split(new char[] { '|' });
                        string[] sValue = av.Split(new char[] { '|' });
                        int myint = 0;
                        textnum = 1;
                        foreach (string myStr in sArray)
                        {
                            TableRow newrow = new TableRow();
                            //newrow.Attributes.Add("Class", "hback");

                            TableCell newcell1 = new TableCell();
                            TableCell newcell2 = new TableCell();
                            textnum++;

                            Label Lab = new Label();
                            string LbId = "Lab" + textnum.ToString();
                            Lab.ID = LbId;
                            Lab.Text = myStr + ":";


                            Label TexB = new Label();
                            string TbId = "Label" + textnum.ToString();
                            TexB.ID = TbId;
                            TexB.Text = sValue[myint];
                            myint++;

                            newcell1.Controls.Add(Lab);
                            newcell2.Controls.Add(TexB);
                            newrow.Cells.Add(newcell1);
                            newrow.Cells.Add(newcell2);
                            Table1.Rows.Add(newrow);

                        }
                    }



                    //txtName.Text = _lt.FNmae;
                    //txtTag.Text = _lt.Fother;
                    //TextC.Text = _lt.F1;
                    //txtTag2.Text = _lx.CTag2;
                    //txtTag3.Text = _lx.CTag3;


                }
            }        
        }

        //保存
        protected void btnSave_Click(object sender, EventArgs e)
        {
             Entities mydb = new Entities();
                  {
                      L_RForm Lt = new L_RForm();
                      Lt = mydb.L_RForm.First(p => p.FrID == _Id);

                   //Lt.FNmae = txtName.Text.Trim();
                   //Lt.Fother = this.txtTag.Text;
                   //Lt.F1 = this.TextC.Text.Trim();
                      
                      if  (this.CheckBox1.Checked)
                      Lt.FrReOk = 0;
                      Lt.FrRepaly = this.txtRe.Text.Trim();

                      Lt.FrReTime = DateTime.Now;

                    mydb.SaveChanges();
                    JscriptPrint("回复成功啦！", "Rlist.aspx", "Success");
                }
   
       

            // bll.Add(model);
            //保存日志
            //SaveLogs("[资讯模块]添加文章：" + model.Title);
            //JscriptPrint("文章发布成功啦！", "Add.aspx?classId=" + ddlClassId.SelectedValue, "Success");
        }


    }


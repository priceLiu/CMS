using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CoolCode.Linq;
using System.Data.Objects;


    public partial class List : AdminBase
    {
        public int classId;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                ClassTreeBind("请选择栏目...", this.Classddl);
                myDatabind();
            }
        }


        private void myDatabind()
        {

            if (!int.TryParse(this.Classddl.SelectedValue as string, out this.classId))
            {
                this.classId = 0;
            }

            //if (classId != 0)
            //{
                using (Entities bll = new Entities())
                {
                    var query = QueryBuilder.Create<L_Newss>();
                    // IQueryable<L_Newss> query = bll.L_Newss;
                    if (this.classId > 0)
                    {
                        //   query = query.Where(p => p.ClassId.Value == this.classId);
                        query.Equals(p => p.ClassId.Value, this.classId);
                    }


                    if (this.ddlProperty.SelectedValue != null)
                    {
                        switch (this.ddlProperty.SelectedValue)
                        {
                            case "IsTop":
                                query.Equals(p => p.IsTop, "1");
                                break;
                            case "IsRed":
                                query.Equals(p => p.IsRed, "1");
                                break;
                            case "IsHot":
                                query.Equals(p => p.IsHot, "1");
                                break;
                            case "IsSlide":
                                query.Equals(p => p.IsSlide, "1");
                                break;
                        }
                    }

                    var Bpl = bll.L_Newss.Where(query.Expression.Compile()).OrderByDescending(p => p.NID).Select(s => new
                    {
                        NId = s.NID,
                        ClassId = s.ClassId,
                        Title = s.Title,
                        Time = s.Time,
                        IsTop = s.IsTop,
                        IsRed = s.IsRed,
                        IsHot = s.IsHot,
                        IsSlide = s.IsSlide,
                        IsLock = s.IsLock

                    })
 ;
                    //var Bpl = bll.L_Newss.Join(bll.L_Classs, a => a.ClassId, b => b.CID, (a, b) => new { a,b }).Where(query.Expression.Compile()).OrderByDescending(a => a.NID);        


                    PagedDataSource pds = new PagedDataSource();
                    pds.DataSource = Bpl.ToList();  //这里好像一定要Tolist();不然会有点错误；
                    pds.AllowPaging = true;
                    AspNetPager1.RecordCount = Bpl.Count(); //记录总数；
                    pds.CurrentPageIndex = AspNetPager1.CurrentPageIndex - 1;
                    pds.PageSize = AspNetPager1.PageSize;



                    //////////////////索引方式:分页操作；

                    ////////////////         // bll.L_Newss.Count();

                    ////////////////      var Bpl = bll.L_Newss.Where(query.Expression.Compile()).OrderByDescending(p => p.NID).Skip(AspNetPager1.StartRecordIndex - 1).Take(AspNetPager1.PageSize).Select(s => new
                    ////////////////    {
                    ////////////////        NId = s.NID,
                    ////////////////        ClassId = s.ClassId,
                    ////////////////        Title = s.Title,
                    ////////////////        Time = s.Time,
                    ////////////////        IsTop = s.IsTop,
                    ////////////////        IsRed = s.IsRed,
                    ////////////////        IsHot = s.IsHot,
                    ////////////////        IsSlide = s.IsSlide,
                    ////////////////        IsLock = s.IsLock

                    ////////////////    });
                    ////////////////      var _page = bll.L_Newss.Where(query.Expression.Compile()).Count();

                    ////////////////      AspNetPager1.RecordCount = Bpl.Count();



                    // string sql = ((ObjectQuery)Bpl).ToTraceString();

                    this.rptList.DataSource = Bpl;
                    this.rptList.DataBind();
                }
            //}

        }



        protected void AspNetPager1_PageChanging(object src, Wuqi.Webdiyer.PageChangingEventArgs e)
        {   //当页面页数改变时，执行这个方法；
            AspNetPager1.CurrentPageIndex = e.NewPageIndex;
            myDatabind();
        }
        protected void rptList_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int id = Convert.ToInt32(((Label)e.Item.FindControl("lb_id")).Text);


            Entities bll = new Entities();
            L_Newss model = bll.L_Newss.First(p => p.NID == id);

            switch (e.CommandName.ToLower())
            {
                case "ibtntop":
                    if (model.IsTop == "1")
                        model.IsTop = "0";
                    else
                        model.IsTop = "1";
                    break;
                case "ibtnred":
                    if (model.IsRed == "1")
                        model.IsRed = "0";
                    else
                        model.IsRed = "1";
                    break;
                case "ibtnhot":
                    if (model.IsHot == "1")
                        model.IsHot = "0";
                    else
                        model.IsHot = "1";
                    break;
                case "ibtnslide":
                    if (model.IsSlide == "1")
                        model.IsSlide = "0";
                    else
                        model.IsSlide = "1";
                    break;
                case "ibtnlock":
                    if (model.IsLock == "1")
                        model.IsLock = "0";
                    else
                        model.IsLock = "1";
                    break;


                case "del":
                    bll.DeleteObject(model);
                    break;

            }

            bll.SaveChanges();
            myDatabind();
            //RptBind("Id>0" + CombSqlTxt(this.kindId, this.classId, this.keywords, this.property), "AddTime desc");
        }


        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            myDatabind();
        }

        protected void ddlProperty_SelectedIndexChanged(object sender, EventArgs e)
        {
            myDatabind();
        }

    }


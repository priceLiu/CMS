using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CoolCode.Linq;
using System.Data.Objects;
using Models;


    public partial class List : AdminBase
    {
        public int classId;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                ClassTreeBind("请选择栏目...", this.Classddl);
                
                if (!string.IsNullOrEmpty(Request.Params["CID"]))
                {
                   string _CId = HttpContext.Current.Request.QueryString["CID"];
                   Classddl.SelectedValue = _CId;
                }

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
                                query.Equals(p => p.IsTop, true);
                                break;
                            case "IsRed":
                                query.Equals(p => p.IsRed, true);
                                break;
                            case "IsHot":
                                query.Equals(p => p.IsHot, true);
                                break;
                            case "IsSlide":
                                query.Equals(p => p.IsSlide, true);
                                break;

                        }
                    }

                    var Bpl = bll.L_Newss.Where(query.Expression.Compile()).OrderByDescending(p => p.Time).Select(s => new
                    {
                        NId = s.NID,
                        ClassId = s.ClassId,
                        Title = s.Title,
                        Time = s.Time,
                        IsTop = s.IsTop,
                        IsRed = s.IsRed,
                        IsHot = s.IsHot,
                        IsSlide = s.IsSlide,
                        IsLock = s.IsLock,
                  

                    });
                    PagedDataSource pds = new PagedDataSource();
                    pds.DataSource = Bpl.ToList();  //这里好像一定要Tolist();不然会有点错误；
                    pds.AllowPaging = true;
                    AspNetPager1.RecordCount = Bpl.Count(); //记录总数；
                    pds.CurrentPageIndex = AspNetPager1.CurrentPageIndex - 1;
                    pds.PageSize = AspNetPager1.PageSize;

                    this.rptList.DataSource = pds;
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
            int id = Convert.ToInt32(e.CommandArgument);


            Entities bll = new Entities();
            L_Newss model = bll.L_Newss.First(p => p.NID == id);

            switch (e.CommandName.ToLower())
            {
                case "ibtntop":
                    if (model.IsTop == true)
                        model.IsTop = false;
                    else
                        model.IsTop = true;
                    break;
                case "ibtnred":
                    if (model.IsRed == true)
                        model.IsRed = false;
                    else
                        model.IsRed = true;
                    break;
                case "ibtnhot":
                    if (model.IsHot == true)
                        model.IsHot = false;
                    else
                        model.IsHot = true;
                    break;
                case "ibtnslide":
                    if (model.IsSlide == true)
                        model.IsSlide = false;
                    else
                        model.IsSlide = true;
                    break;
                case "ibtnlock":
                    if (model.IsLock == true)
                        model.IsLock = false;
                    else
                        model.IsLock = true;
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


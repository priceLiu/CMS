using System;

    /// <summary>
    /// 系统日志实体类
    /// </summary>
    /// <summary>
    /// 管理员登录日志:实体类
    /// </summary>
    [Serializable]
    public partial class manager_log
    {
        public manager_log()
        { }
        #region Model
        private int _id;
        private int _user_id;
        private string _user_name;
        private string _action_type;
        private string _note;
        private string _login_ip;
        private DateTime _login_time=DateTime.Now;
        /// <summary>
        /// 自增ID
        /// </summary>
        public int id
        {
            set { _id = value; }
            get { return _id; }
        }
        /// <summary>
        /// 用户ID
        /// </summary>
        public int user_id
        {
            set { _user_id = value; }
            get { return _user_id; }
        }
        /// <summary>
        /// 用户名
        /// </summary>
        public string user_name
        {
            set { _user_name = value; }
            get { return _user_name; }
        }
        /// <summary>
        /// 操作类型
        /// </summary>
        public string action_type
        {
            set { _action_type = value; }
            get { return _action_type; }
        }
        /// <summary>
        /// 备注
        /// </summary>
        public string note
        {
            set { _note = value; }
            get { return _note; }
        }
        /// <summary>
        /// 登录IP
        /// </summary>
        public string login_ip
        {
            set { _login_ip = value; }
            get { return _login_ip; }
        }
        /// <summary>
        /// 登录时间
        /// </summary>
        public DateTime login_time
        {
            set { _login_time = value; }
            get { return _login_time; }
        }
        #endregion Model

    }
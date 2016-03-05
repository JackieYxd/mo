#include <stdio.h>
#include <stdlib.h>
#define Q 8//学号长度
#define W 21
#define N 20
#define PAGE 3               
struct bir
{
    int year;
    int month;
    int day;
};
struct student
{
    char num[Q];
    char name[21];
    char sex;
    struct bir birthday;
    float score;
};
int read_file(struct student stu[])
{
    FILE *fp;
    int i=0;
    if((fp=fopen("成绩信息.txt","rt"))==NULL)
    {   printf("\n\n*****文件不存在！请创建");
        return 0;
    }
    while(feof(fp)!=1)
    {
        fread(&stu[i],sizeof(struct student),1,fp);
        if(stu[i].num==0)
            break;
        else 
            i++;
    }
    fclose(fp);
    return i;
}
void save_file(struct student stu[],int sum)
{
    FILE *fp;
    int i;
    if((fp=fopen("成绩信息.txt","wb"))==NULL)
    {
        printf("读文件错误！\n");
        return;
    }
    for(i=0;i<sum;i++)
        if(fwrite(&stu[i],sizeof(struct student),1,fp)!=1)
            printf("写文件错误！\n");
        fclose(fp);
}
int input(struct student stu[]) 
{
    int i=0,n;
    system("cls");
    printf("请输入学生数量");
    scanf("%d",n);
    for(i=1;i<=n;i++)
    {
        printf("请输入学生姓名(其中可以包含空格)：");
        gets(stu[i].name);
        printf("请输入学生学号：");
        scanf("%s",stu[i].num);
        printf("请输入学生性别：");
        scanf("%c",&stu[i].sex);
        printf("请输入学生生日：");
        scanf("%15d-%2d-%2d",&stu[i].birthday.year,&stu[i].birthday.month,&stu[i].birthday.day);
        printf("请输入学生成绩：");
        scanf("%f",&stu[i].score);
        getchar();
        printf("\t");
        printf("本学生信息输入完毕！");
    }
    printf("\n                  ----所有学生信息输入完毕！----\n",i);
    printf("\n                       按任意键返回主菜单！");
    getchar();
    return i;
}
void output(struct student stu[],int sum)
{
    int i=0,j=0,page=1;
    system("cls");
    printf("\n\n           --学生信息表--            第%d页\n\n",page);
    printf(" 学号---姓名---性别---生日（年-月-日）---成绩\n");
    printf("------------------------------------------------\n");
    while(stu[i].num)
    {
        if(stu[i].num)
        {
            j++;
            if(j%page)
        	{
                printf("%8s %s %c %15d-%2d-%2d %f\n",stu[i].num,
                        stu[i].name,stu[i].sex,
                        stu[i].birthday.year,
                        stu[i].birthday.month,
                        stu[i].birthday.day,
                        stu[i].score);
                printf("-------------------------------------------------------\n");
        	}
            else
        	{
                printf("按任意键继续！");
                getchar();
                system("cls");
                printf("\n\n   --学生信息表--         第%d页\n\n",++page);
                printf("学号---姓名---性别---生日（年-月-日）---成绩\n");
                printf("-------------------------------------------------------");
                printf("%8s %s %c %15d-%2d-%2d %f\n",stu[i].num,
                        stu[i].name,stu[i].sex,
                        stu[i].birthday.year,
                        stu[i].birthday.month,
                        stu[i].birthday.day,
                        stu[i].score);
                printf("-------------------------------------------------------");
        	}
        }
        i++;
    }
    printf("按任意键返回主菜单！");
    getchar();
}
void sort(struct student stu[],int sum)//成绩排行
{
    struct student t;
    int i,j,k;
    system("cls");
    printf("\n                                      成绩排行\n");
    printf("-----------------------------------------------------\n");
    printf("\n\t排名\t学号\t姓名\t性别\t成绩\t");
    for(i=0;i<sum;i++)
    {
        k=i;
        for(j=i+1;j<sum;j++)
            if(stu[k].score<stu[j].score) k=j;
            if(k-i)
    		{
                t=stu[i];
                stu[i]=stu[k];
                stu[k]=t;
    		}
    }
    output(stu,sum);
    getchar();                                                 //bioskey()
}

void modify(struct student stu[],int sum)//修改学生信息
{
    int i=0,choice,modify_num,flag;
    while(flag==1)
    {
        system("cls");
        printf("\n                      输入要修改的学生学号：");
        scanf("%d",&modify_num);
        for(i=1;i<sum;i++)
            if(stu[i].num==modify_num)
    		{
                printf("\n              --学生信息--\n");
                printf("学号---姓名---性别---生日（年-月-日）---成绩\n");
                printf("-----------------------------------------------\n");
                printf("%8s %s %c %15d-%2d-%2d %f\n",stu[i].num,
                        stu[i].name,stu[i].sex,
                        stu[i].birthday.year,stu[i].birthday.month,stu[i].birthday.day,
                        stu[i].score);
                printf("\n                       请问您要修改哪一项？\n");
                printf("\n                           1.姓名");
                printf("\n                           2.生日");
                printf("\n                           3.成绩");
                printf("\n                           请选择 1-4  ：");
                scanf("%d",&choice);
                switch(choice)
        		{
                    case 1: printf("                              输入修改后的姓名：");
                        scanf("%s",stu[i].name);break;
                    case 2: printf("                              输入修改后的生日：");
                        scanf("%15d-%2d-%2d",stu[i].birthday.year,stu[i].birthday.month,stu[i].birthday.day);break;
                    case 3: printf("                              输入修改后的成绩：");
                        scanf("%f",stu[i].score);break;
        		}
                printf("\n                       ---学生信息---\n");
                printf("学号---姓名---性别---生日（年-月-日）---成绩\n");
                printf("-----------------------------------------------\n");
                printf("%8s %s %c %15d-%2d-%2d %f\n",stu[i].num,
                        stu[i].name,stu[i].sex,
                        stu[i].birthday.year,stu[i].birthday.month,stu[i].birthday.day,
                        stu[i].score);
            	break;
    		}
            if(i=sum)
    		{
                printf("\n                                 该学生不存在！");
                getchar();              //bioskey(0);
    		}
            printf("\n\n                                    继续修改吗？(Y/N)");
            choice=getchar();
            if(choice=='Y'||choice=='y')
    		{
            	flag=1;
                printf("\n                                 继续！\n");

    		}
            else flag=0;
    }
    printf("\n                                       按任意键返回主菜单！");
    getchar();                                  //bioskey(0);
}





int main(void)
{
   	struct student stu[N];
    int choice,sum;
    sum=read_file(stu);
    if(sum==0)
    {
        printf("并录入基本信息！*****\n");
        getchar();
        sum=input(stu);
    }
    do
    {
        system("cls");
        printf("\n\n\n\n          **********学生成绩管理系统**********\n\n");
        printf("                            1.添加学生信息\t");
        printf("                            2.修改学生信息\t");
        printf("                            3.删除学生信息\t");
        printf("                            4.打印学生信息库信息\t");
        printf("                            5.查询学生信息\t");
        printf("                            6.统计学生信息\t");
        printf("                            7.学生成绩排行\t");
        printf("                            0.退出系统\t");
        printf("                               请选择0-6：");
        scanf("%d",&choice);
        switch(choice)
        {
       // case 1: append(); break;
        case 2: modify(stu,sum); break;
       // case 3: del();break;
        case 4: output(stu,sum); break;
       // case 5: inqire();break;
       // case 6: count();break;
        case 7: sort(stu,sum);break;
        case 0: break;

        }
    }while(choice);
    save_file(stu,sum);

}

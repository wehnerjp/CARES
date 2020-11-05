using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Configuration;

namespace CIS484Solution1
{
    public class AccessCode
    {
        const string lower = "abcdefghijklmnopqursuvwxyz";
        const string upper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        const string num = "123456789";
        const string other = @"!@£$%^&*()#€";
        ArrayList codeList = new ArrayList();

        public string GenerateCode(bool lowercase, bool uppercase, bool numbers, bool otherChar,
            int codeSize)
        {
            codeSize = 8;
            char[] code = new char[codeSize];
            string charSet = "";
            System.Random random = new Random();
            int counter;

            if (lowercase) charSet += lower;

            if (uppercase) charSet += upper;

            if (numbers) charSet += num;

            if (otherChar) charSet += other;

            for (counter = 0; counter < codeSize; counter++)
            {
                code[counter] = charSet[random.Next(charSet.Length - 1)];
            }
            bool Contains = codeList.Contains(code);
            if (!Contains)
            {
                codeList.Add(code);
            }
            else
            {
                GenerateCode(lowercase,uppercase, numbers, otherChar, codeSize);
            }
            return String.Join(null, code);
        }
    }

}
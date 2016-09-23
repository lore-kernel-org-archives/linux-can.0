From: =?UTF-8?Q?Andr=c3=a9_Hartmann?= <aha_1980@gmx.de>
Subject: Re: libsocketcan proposal for upstream (get typekind vcan or can,
 etc.)
Date: Fri, 23 Sep 2016 12:19:17 +0200
Message-ID: <7c0a6023-6a14-9af0-a297-d721ffcc0b16@gmx.de>
References: <CAPgtGZNhuinRb-gpj9QkTVnhfY8PE03JKoqhKm8Lw3g2s1+rzw@mail.gmail.com>
 <CAPgtGZOuJEkRC+X4yWz8E4Qp1SZivkj6RV9kZ3RPJ20MUBAfUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:58389 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752747AbcIWKTa (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 23 Sep 2016 06:19:30 -0400
In-Reply-To: <CAPgtGZOuJEkRC+X4yWz8E4Qp1SZivkj6RV9kZ3RPJ20MUBAfUA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: aj neu <ajneu1@gmail.com>, linux-can@vger.kernel.org, mkl@pengutronix.de

Am 23.09.2016 um 08:19 schrieb aj neu:
> On Fri, Sep 23, 2016 at 8:16 AM, aj neu wrote:
>> Hello,
>>
>> below, please find a patch which adds the following functions to libsocketcan
>>
>>     device_exists, device_is_up, can_get_typekind
>>
>>     int device_exists(const char *name);
>>      // determine if device is libsocketcan-compatible and exists
>>
>>     int device_is_up(const char *name);
>>      // determine if device is up (also usable for vcan)
>>
>>     int can_get_typekind(const char *name, char *buf, size_t buflen);
>>      // determine if typekind is "can" or "vcan"
>>
>>
>> The patch can be applied to
>> https://git.platon.pengutronix.de/cgit/tools/libsocketcan
>> as follows:
>>    git apply diff.patch
>>
>>
>> Can this be applied to upstream?
>>
>> Thanks.
>> ajneu
>
> Here's the patch as attachment.
>

Hello AJ,

without having a deeper look at your patch, I think it is a quite useful 
addition. Please find my comments below.

 >>     int device_exists(const char *name);

This is good, but even better would be something that enumerates 
available interfaces. Looking for available interfaces is a common task, 
I guess. Something like Kurt's library [1] does and what I do in 
QtSerialBus [2] because I was unable to use [1] because of license 
reasons :(

 >>     int device_is_up(const char *name);

OK, if device_exists returns true for devices that are not up.

 >>     int can_get_typekind(const char *name, char *buf, size_t buflen);

Can buf contains anything else beside "can" and "vcan"? If not, I 
instead propose a more concise function:

     int device_is_virtual(const char *name);

Regarding the patch itself:

Marc, what do you say? Will you accept patches to libsocketcan  The last 
commits are from 2014...

And last, one more comment to the code:

+case GET_TYPEKIND:
+  if (!linkinfo[IFLA_INFO_KIND])
+    fprintf(stderr, "no type-kind found\n");
+  else {

I don't know if there are any rules in libsocketcan, but I really prefer 
having curly braces { } around the if also, when there are curly braces 
around the else branch.

+    const size_t buflen = ((struct str_buf *)res)->capacity;
+    if (buflen) {
+      char * const buf = ((struct str_buf *)res)->buf;
+      *buf = '\0';
+      strncat(buf, RTA_DATA(linkinfo[IFLA_INFO_KIND]), buflen-1);

First I asked why not using strncpy, but I guess this is a trick to make 
sure buf is null-terminated? On the other hand, the following code is 
not longer (buflen - 1 is allowed because you checked for zero already):

       strncpy(buf, RTA_DATA(linkinfo[IFLA_INFO_KIND]), buflen);
       buf[buflen - 1] = '\0';

+    }
+    ret = 0;
+}

Best regards,
André

[1] https://github.com/kurt-vd/enumif
[2] 
https://codereview.qt-project.org/#/c/166460/13/src/plugins/canbus/socketcan/socketcanbackend.cpp



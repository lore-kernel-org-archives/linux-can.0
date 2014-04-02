From: JUAN PEDRO RODRIGUEZ NIETO <jprodriguez@elecnor.com>
Subject: Re: PCH_CAN - echo_skb is occupied
Date: Wed, 2 Apr 2014 10:35:24 +0200
Message-ID: <CA+vJB=xaTzCb3uzhRh5AOhsToiaqPZKRF9CSKG+FnSmR5hMw6w@mail.gmail.com>
References: <CA+vJB=yJ_tF1UwdwpLMVVYMKpTCQCYhWdFGGQNQNn2iP=1V3-A@mail.gmail.com>
	<533B138B.1010904@grandegger.com>
Reply-To: jprodriguez@elecnor.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44]:54768 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757956AbaDBIl7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 2 Apr 2014 04:41:59 -0400
Received: by mail-qg0-f44.google.com with SMTP id a108so10373621qge.31
        for <linux-can@vger.kernel.org>; Wed, 02 Apr 2014 01:41:58 -0700 (PDT)
In-Reply-To: <533B138B.1010904@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org

Hello,

I am using Linux 3.10.11-yocto-standard kernel compiled using poky-dora=
-10.0.1

I didn't know about the C_CAN driver. What is the status of the C_CAN d=
river?
I have found that in Kernel configuration/Networking support/CAN bus
subsystem support/CAN device drivers there is a Generic PCI bus based
C_CAN/D_CAN driver. I will try it.

Thanks,
Juan Pedro Rodr=EDguez Nieto
Delegaci=F3n de Sistemas




Rambla Solanes, 29-31
08940 Cornell=E0 de Llobregat, Barcelona
Tel.: 934 139 200
=46ax: 934 139 201


2014-04-01 21:29 GMT+02:00 Wolfgang Grandegger <wg@grandegger.com>:
> On 03/31/2014 11:59 AM, JUAN PEDRO RODRIGUEZ NIETO wrote:
>> I am using a Q7 module with Atom processor and EG20T. I am using the
>> latest Yocto Dora 10.0.0 to build the embedded linux image. This ima=
ge
>> is still using pch_can.c driver, with the "echo_skb is occupied"
>> problem.
>>
>> I have checked with your post
>> http://marc.info/?l=3Dlinux-can&m=3D137180949810229&w=3D2
>> and the source code of pch_can does not have your patch applied.
>>
>> I am not familiar with kernel patching. Could you please direct me
>> where can I find the latest pch_can and how to download your patch i=
n
>> patch file format so I can apply it to my poky build?
>>
>> Is there any plan to release these patches in the master branch?
>
> The EG20T does have a C_CAN core and therefore we would like to switc=
h
> to the more advanced C_CAN driver (and get rid of the pch_can driver
> sooner than later). It also has less known issues. Last year I posted=
 a
> PCH PCI interface driver for the EG20T but it did not make it into
> mainline yet. The problem is that I don't have any C_CAN hardware at
> hand to validate the patches myself. I'm going to dig the patches out=
,
> end of the week, also for the pch_can.
>
> BTW, what kernel version are you using? Any chance to switch to a rec=
ent
> mainline kernel?
>
> Wolfgang.

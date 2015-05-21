From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: J1939 message length
Date: Thu, 21 May 2015 22:22:04 +0200
Message-ID: <555E3E6C.2020407@hartkopp.net>
References: <loom.20141211T112702-791@post.gmane.org> <20141212110743.GC10796@vandijck-laurijssen.be> <6726_1418633895_548EA2A7_6726_15776_1_F1366246CF364C42B98553900CE0C5CB07FE75B7@PEXCVZYM13.corporate.adroot.infra.ftgroup> <20141215093136.GA646@vandijck-laurijssen.be> <306_1430126538_553DFFCA_306_19026_1_F1366246CF364C42B98553900CE0C5CB0801EF73@PEXCVZYM11.corporate.adroot.infra.ftgroup> <20150519084626.GC1088@vandijck-laurijssen.be> <26458_1432042025_555B3A29_26458_297_2_F1366246CF364C42B98553900CE0C5CB08028AE4@PEXCVZYM11.corporate.adroot.infra.ftgroup> <CAA7hF3y7+j_TZ4nTak8t5Y4ejmE2fOFWxRBKJbrHLiFts_+8eg@mail.gmail.com> <20150519210131.GC29137@vandijck-laurijssen.be> <15657_1432221395_555DF6D3_15657_7688_1_F1366246CF364C42B98553900CE0C5CB08028C85@PEXCVZYM11.corporate.adroot.infra.ftgrou
 p>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:53874 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755314AbbEUUWU (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 21 May 2015 16:22:20 -0400
In-Reply-To: <15657_1432221395_555DF6D3_15657_7688_1_F1366246CF364C42B98553900CE0C5CB08028C85@PEXCVZYM11.corporate.adroot.infra.ftgroup>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: pfifre.ext@orange.com, Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>, laurent vaudoit <laurent.vaudoit@gmail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>



On 05/21/2015 05:16 PM, pfifre.ext@orange.com wrote:
> Hi All,
> 
> My j1939 works fine! Thanks a lot.
> 
> Now, I need to implement diagnostic ISOTP protocol on the same link.
> I tried isotpsend tool to make a simple test first but this tool told me that the protocol is not supported.
> Does it mean that I need to select in the kernel?
> 
> I looked for isotp.c in the kernel (net/can/isotp.c) but nothing like here.
> 
> Do you know if I need to upgrade the kernel or add user mode modules?


Hi Pascal,

the ISOTP stuff is currently outside the mainline tree too.
There are some minor things to clarify for the blocking of big PDU chunks in
the socket interface.

Btw. you can clone the isotp development repository from here:

https://github.com/hartkopp/can-isotp-modules

git clone https://github.com/hartkopp/can-isotp-modules.git

Then do

cd can-isotp-modules/net/can
./make_isotp.sh

which should create a can-isotp.ko module file you can load into your kernel:

insmod ./can-isotp.ko

That should make it :-)

Please read the README.isotp file from

https://github.com/hartkopp/can-isotp-modules

especially for the tx-queue-len configuration for you CAN netdevice.

Regards,
Oliver


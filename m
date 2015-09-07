From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: RE: J1939 + iMX6 + yocto
Date: Mon, 07 Sep 2015 02:40:21 +0200
Message-ID: <36853685-8336-4C81-88CE-AE3CB1A36AFA@vandijck-laurijssen.be>
References: <loom.20141211T112702-791@post.gmane.org> <20141212110743.GC10796@vandijck-laurijssen.be> <6726_1418633895_548EA2A7_6726_15776_1_F1366246CF364C42B98553900CE0C5CB07FE75B7@PEXCVZYM13.corporate.adroot.infra.ftgroup> <20141215093136.GA646@vandijck-laurijssen.be> <306_1430126538_553DFFCA_306_19026_1_F1366246CF364C42B98553900CE0C5CB0801EF73@PEXCVZYM11.corporate.adroot.infra.ftgroup> <20150519084626.GC1088@vandijck-laurijssen.be> <18596_1441369456_55E98D70_18596_3092_1_F1366246CF364C42B98553900CE0C5CB089DBAF9@OPEXCLILM23.corporate.adroot.infra.ftgroup>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relaygateway02.edpnet.net ([212.71.1.211]:33239 "EHLO
	relaygateway02.edpnet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752915AbbIGAuR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 6 Sep 2015 20:50:17 -0400
In-Reply-To: <18596_1441369456_55E98D70_18596_3092_1_F1366246CF364C42B98553900CE0C5CB089DBAF9@OPEXCLILM23.corporate.adroot.infra.ftgroup>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: pfifre.ext@orange.com
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi,


On 4 September 2015 14:24:15 CEST, pfifre.ext@orange.com wrote:
>Hi Kurt,
>
>I continue my works on J1939 on another platform (based on IMX6 and
>Yocto).

I'm currently using the same iMX6 with yocto. 

>
>I try now to patch the Yocto Kernel to embed your J1939 stack.
>But, this yocto kernel is based on 3.10-r0 and the nearest version of
>your git is for 3.8 or for 3.12-rc1 kernels.
>
>I tried to patch with the git J1939-v3.8 and lot of conflicts appears
>during merge.
>I think I will have the same issues with 3.12-rc1.
>
You need first to rebase the j1939 branch onto 3.10, or else you merge everything including 3.12.

>I suppose that modifications of the kernel are limited to can stack and
>can drivers. I'm right?

Can stack only, no drivers.

>Can I patch my kernel manualy with the specific J1939 sources and adapt
>their structures to my kernel version?

You should merge using git and resolve merge conflicts on the way.
I cannot tell from my current position which branch to start best with.
Or you could wait until Tuesday, then I can push a my 3.10 branch. I've gone through the merge conflicts already...

>
>What do you think about that?
>
>Best regards,
>
>Pascal
>

Sent from a small mobile device

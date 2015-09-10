From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: J1939 + iMX6 + yocto
Date: Thu, 10 Sep 2015 13:34:19 +0200
Message-ID: <20150910113419.GA13189@airbook.eia.lan>
References: <20141212110743.GC10796@vandijck-laurijssen.be>
 <6726_1418633895_548EA2A7_6726_15776_1_F1366246CF364C42B98553900CE0C5CB07FE75B7@PEXCVZYM13.corporate.adroot.infra.ftgroup>
 <20141215093136.GA646@vandijck-laurijssen.be>
 <306_1430126538_553DFFCA_306_19026_1_F1366246CF364C42B98553900CE0C5CB0801EF73@PEXCVZYM11.corporate.adroot.infra.ftgroup>
 <20150519084626.GC1088@vandijck-laurijssen.be>
 <18596_1441369456_55E98D70_18596_3092_1_F1366246CF364C42B98553900CE0C5CB089DBAF9@OPEXCLILM23.corporate.adroot.infra.ftgroup>
 <36853685-8336-4C81-88CE-AE3CB1A36AFA@vandijck-laurijssen.be>
 <12979_1441607513_55ED2F59_12979_6_1_F1366246CF364C42B98553900CE0C5CB089DBBE6@OPEXCLILM23.corporate.adroot.infra.ftgroup>
 <20150908075800.GA864@airbook.eia.lan>
 <10825_1441878970_55F153BA_10825_1523_1_e2938c8e-30db-4942-96df-1d6a7628d355@OPEXCLILM7D.corporate.adroot.infra.ftgroup>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relaygateway02.edpnet.net ([212.71.1.211]:21607 "EHLO
	relaygateway02.edpnet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928AbbIJLei (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 10 Sep 2015 07:34:38 -0400
Content-Disposition: inline
In-Reply-To: <10825_1441878970_55F153BA_10825_1523_1_e2938c8e-30db-4942-96df-1d6a7628d355@OPEXCLILM7D.corporate.adroot.infra.ftgroup>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: pfifre.ext@orange.com
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>


> Date: Thu, 10 Sep 2015 09:56:06 +0000
> 
> Hi Kurt,
> 
> I tried to patch my Kernel (3.10r0) with the j1939-v3.10 and lot of conflicts appears again.

Did you follow the steps that I explained on http://elinux.org#J1939?
It should work, unless you are not on a v3.10 branch of your repository.

> I noticed that I have also conflicts with the documentation repository in kernel. It seems to be strange, no?
> 
> If I just want to add j1939 stack, can I try this:
> 1) Add j1939 repository from your git sources in <linux kernel>/net/can/j1939
> 2) Mofidy Kconfig and Makefile in net/can to add j1939
> 3) Put the can.h from your from your git sources in <linux kernel>/include/linux/can.h
> 4) Modifiying af_can.c to :
> 	a) add these functions : can_rtl_doit, can_rtnl_dumpit, can_rtln_dump_addr, can_get_link_af_size, can_fill_link_af, can_validate_link_af, can_set_link_af
> 	b) add these structure : can_rtnl-af_ops
> 	c) Modify init_can to call rtl functions
> 5) Make a patch for Yocto with these

You can use git to show the diff between v3.10 and j1939-v3.10.

> 
> What do you think about this?
> 
> BTW, for another target, I try to get iproute2-j1939 from your github to compile for a 3.8 kernel, and the branches j1939-vX.X disappear. I found only the master branch. Is it normal?
No.
I see all branches, but that are not as many as branches in the kernel.
The iproute2 of a newer version is usable on older versions.

Kurt

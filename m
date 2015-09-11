From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: J1939 + iMX6 + yocto
Date: Fri, 11 Sep 2015 05:49:36 +0200
Message-ID: <20150911034936.GA23393@airbook.vandijck-laurijssen.be>
References: <20150519084626.GC1088@vandijck-laurijssen.be>
 <18596_1441369456_55E98D70_18596_3092_1_F1366246CF364C42B98553900CE0C5CB089DBAF9@OPEXCLILM23.corporate.adroot.infra.ftgroup>
 <36853685-8336-4C81-88CE-AE3CB1A36AFA@vandijck-laurijssen.be>
 <12979_1441607513_55ED2F59_12979_6_1_F1366246CF364C42B98553900CE0C5CB089DBBE6@OPEXCLILM23.corporate.adroot.infra.ftgroup>
 <20150908075800.GA864@airbook.eia.lan>
 <10825_1441878970_55F153BA_10825_1523_1_e2938c8e-30db-4942-96df-1d6a7628d355@OPEXCLILM7D.corporate.adroot.infra.ftgroup>
 <20150910113419.GA13189@airbook.eia.lan>
 <2144_1441891087_55F1830F_2144_9033_1_72e71e6a-832b-4f03-b5a6-47ea4e7bb890@OPEXCLILMA3.corporate.adroot.infra.ftgroup>
 <55F185FF.3030400@pengutronix.de>
 <17840_1441899129_55F1A279_17840_5145_1_32faddc5-c842-4de6-9f1a-8ca0e47ed042@OPEXCLILMA4.corporate.adroot.infra.ftgroup>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relaygateway02.edpnet.net ([212.71.1.211]:53048 "EHLO
	relaygateway02.edpnet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007AbbIKDtm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 10 Sep 2015 23:49:42 -0400
Content-Disposition: inline
In-Reply-To: <17840_1441899129_55F1A279_17840_5145_1_32faddc5-c842-4de6-9f1a-8ca0e47ed042@OPEXCLILMA4.corporate.adroot.infra.ftgroup>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: pfifre.ext@orange.com
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

> In fact is a 3.10-r0 and not 3.10r0.
> But you are right : it's not an official release.
> 

git diff v3.10.. --stat -- net/can/ include/linux/can include/uapi/linux/can.h include/uapi/linux/can

yielded this to my side, after applying j1939 and everything.

 include/linux/can/core.h       |   31 +
 include/linux/can/dev.h        |    2 +
 include/uapi/linux/can.h       |   20 +-
 include/uapi/linux/can/Kbuild  |    1 +
 include/uapi/linux/can/j1939.h |   99 +++
 net/can/Kconfig                |    2 +
 net/can/Makefile               |    2 +
 net/can/af_can.c               |  213 +++++-
 net/can/bcm.c                  |    4 +-
 net/can/j1939/Kconfig          |   22 +
 net/can/j1939/Makefile         |   14 +
 net/can/j1939/address-claim.c  |  227 +++++++
 net/can/j1939/bus.c            |  516 ++++++++++++++
 net/can/j1939/filter.c         |   76 +++
 net/can/j1939/j1939-priv.h     |  314 +++++++++
 net/can/j1939/main.c           |  463 +++++++++++++
 net/can/j1939/proc.c           |   81 +++
 net/can/j1939/promisc.c        |   43 ++
 net/can/j1939/rtnl.c           |  306 +++++++++
 net/can/j1939/socket.c         |  984 +++++++++++++++++++++++++++
 net/can/j1939/transport.c      | 1449 ++++++++++++++++++++++++++++++++++++++++
 net/can/raw.c                  |    4 +-
 22 files changed, 4867 insertions(+), 6 deletions(-)

What does your v3.10-r0, before applying j1939?

> Yes, I think so : I will talk with my provider.
> 
> I try also another way : 
> 1) get an official release of 3.10
> 2) make a patch with  the j1939 release
> 3) try to apply the patch to my kernel and see

Sounds like a good plan to try!

Kurt

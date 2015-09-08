From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: J1939 + iMX6 + yocto
Date: Tue, 8 Sep 2015 14:32:49 +0200
Message-ID: <20150908123249.GC25796@airbook.eia.lan>
References: <20141212110743.GC10796@vandijck-laurijssen.be>
 <6726_1418633895_548EA2A7_6726_15776_1_F1366246CF364C42B98553900CE0C5CB07FE75B7@PEXCVZYM13.corporate.adroot.infra.ftgroup>
 <20141215093136.GA646@vandijck-laurijssen.be>
 <306_1430126538_553DFFCA_306_19026_1_F1366246CF364C42B98553900CE0C5CB0801EF73@PEXCVZYM11.corporate.adroot.infra.ftgroup>
 <20150519084626.GC1088@vandijck-laurijssen.be>
 <18596_1441369456_55E98D70_18596_3092_1_F1366246CF364C42B98553900CE0C5CB089DBAF9@OPEXCLILM23.corporate.adroot.infra.ftgroup>
 <36853685-8336-4C81-88CE-AE3CB1A36AFA@vandijck-laurijssen.be>
 <12979_1441607513_55ED2F59_12979_6_1_F1366246CF364C42B98553900CE0C5CB089DBBE6@OPEXCLILM23.corporate.adroot.infra.ftgroup>
 <20150908075800.GA864@airbook.eia.lan>
 <22033_1441704817_55EEAB71_22033_5373_1_F1366246CF364C42B98553900CE0C5CB089DBCCA@OPEXCLILM23.corporate.adroot.infra.ftgroup>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Bu8it7iiRSEf40bY"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relaygateway02.edpnet.net ([212.71.1.211]:29233 "EHLO
	relaygateway02.edpnet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754346AbbIHMdC (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 Sep 2015 08:33:02 -0400
Content-Disposition: inline
In-Reply-To: <22033_1441704817_55EEAB71_22033_5373_1_F1366246CF364C42B98553900CE0C5CB089DBCCA@OPEXCLILM23.corporate.adroot.infra.ftgroup>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: pfifre.ext@orange.com
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>


--Bu8it7iiRSEf40bY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

--- Original message ---
> Date: Tue, 8 Sep 2015 09:33:35 +0000
> From: pfifre.ext@orange.com
> To: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
> CC: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
> Subject: RE: J1939 + iMX6 + yocto
> 
> > I also updated iproute2-j1939, to a version that is equal to what yocto is using now.
> What do you mean? Do you patch iproute2 for using j1939? In that case how can I retrieve this iproute2-j1939 stack to use it in yocto?

See http://elinux.org/J1939#Sources

You need a patched iproute2 ip program to activate j1939 on a CAN
device. Altough I had an iproute2 ready, I could not get it easily
in yocto to compile. So I created iproute2-j1939 v3.16 branch,
which equals the iproute2 version that (my) yocto uses.
I then added the bitbake recipe (see attachment) which reuses
all patches applied to the stock iproute2 program.


--Bu8it7iiRSEf40bY
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="iproute2-j1939_3.16.bb"

FILESEXTRAPATHS_prepend := "${THISDIR}/../../../poky/meta/recipes-connectivity/iproute2/iproute2:"
require ../../../poky/meta/recipes-connectivity/iproute2/iproute2.inc

SRC_URI = "git://github.com/kurt-vd/iproute2.git;protocol=git;branch=j1939-v3.16 \
           file://configure-cross.patch \
           file://0001-iproute2-de-bash-scripts.patch \
           file://0001-ip-link-Remove-unnecessary-device-checking.patch \
	   "


SRCREV = "be0377ecb5a2129fc7f2f8eabeae7f68d9f44e99"
S = "${WORKDIR}/git"

# CFLAGS are computed in Makefile and reference CCOPTS
#
EXTRA_OEMAKE_append = " CCOPTS='${CFLAGS}'"
ALTERNATIVE_PRIORITY = "120"
ALTERNATIVE_TARGET[ip] = "${base_sbindir}/ip.iproute2-j1939"

# install: only install the 'ip' tool itself, not the complete package.
# If the complete package is required, just install the regular iproute2 tool.
# PS: you are free to install the exact same iproute2 version.
do_install () {
	install -D ${S}/ip/ip ${D}${base_sbindir}/ip.iproute2-j1939
}

--Bu8it7iiRSEf40bY--

From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: RE: J1939 + iMX6 + yocto
Date: Fri, 18 Sep 2015 14:10:33 +0200
Message-ID: <C1AAF45F-6C7C-4AB1-93E3-3FEE36B5CF83@vandijck-laurijssen.be>
References: <20141212110743.GC10796@vandijck-laurijssen.be> <20141215093136.GA646@vandijck-laurijssen.be> <306_1430126538_553DFFCA_306_19026_1_F1366246CF364C42B98553900CE0C5CB0801EF73@PEXCVZYM11.corporate.adroot.infra.ftgroup> <20150519084626.GC1088@vandijck-laurijssen.be> <18596_1441369456_55E98D70_18596_3092_1_F1366246CF364C42B98553900CE0C5CB089DBAF9@OPEXCLILM23.corporate.adroot.infra.ftgroup> <36853685-8336-4C81-88CE-AE3CB1A36AFA@vandijck-laurijssen.be> <12979_1441607513_55ED2F59_12979_6_1_F1366246CF364C42B98553900CE0C5CB089DBBE6@OPEXCLILM23.corporate.adroot.infra.ftgroup> <20150908075800.GA864@airbook.eia.lan> <22033_1441704817_55EEAB71_22033_5373_1_F1366246CF364C42B98553900CE0C5CB089DBCCA@OPEXCLILM23.corporate.adroot.infra.ftgroup> <20150908123249.GC25796@airbook.eia.lan> <19625_14425
 67071_55FBD39E_19625_433_1_a28ef7d8-1702-43c1-afda-ae52611932b1@OPEXCLILM7E.corporate.adroot.infra.ftgroup>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relaygateway02.edpnet.net ([212.71.1.211]:43029 "EHLO
	relaygateway02.edpnet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751786AbbIRMLL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 18 Sep 2015 08:11:11 -0400
In-Reply-To: <19625_1442567071_55FBD39E_19625_433_1_a28ef7d8-1702-43c1-afda-ae52611932b1@OPEXCLILM7E.corporate.adroot.infra.ftgroup>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: pfifre.ext@orange.com
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>



On 18 September 2015 11:04:29 CEST, pfifre.ext@orange.com wrote:
>Hi Kurt,
>
>I add the Yocto patch yesterday in my distribution.
>It's very strange, because it seems to be applied on build (it appears
>on the Build without errors) but not on the distribution: I can't add
>any j1939 link (either "dev" is duplicate, or "j1939" is a garbage).

The warning comes from iproute2. Did you patch that already?

>Apparently, bitbake finds the necessary files.
>I have just one warning at build : the file
>file://0001-ip-link-Remove-unnecessary-device-checking.patch doesn't be
>found by the build (not present on poky, then I removed this line in
>the bb).
>
>In fact, I notice that the git command in the bb doesn't work. I have
>made a voluntary error in the path and the build ran with no errors.
>Then, your patch is no applied to the distribution.
>
>Do you have any idea?
>
>It's the last task I have to do to run all the features of my
>application.
>
>Thanks for your support.
>
>Best regards,
>
>Pascal
>

Sent from a small mobile device

From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: RE: MCP2515 implementation is slow
Date: Wed, 26 Nov 2014 12:32:42 +0000
Message-ID: <20141126123242.13254.31551@shannon>
References: <84a1d29551f84f5494b309e1ad1e0840@SGPMBX1004.APAC.bosch.com>
 <5474B2BD.1030901@eurekelettronica.it>
 <2E9F00CBB66AB544A1ACDC59627518BA4F02C96C@mailserver>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-db3on0079.outbound.protection.outlook.com ([157.55.234.79]:36352
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750828AbaKZMct convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 26 Nov 2014 07:32:49 -0500
In-Reply-To: <2E9F00CBB66AB544A1ACDC59627518BA4F02C96C@mailserver>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Rost, Martin" <Martin.Rost@tonfunk.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Quoting Rost, Martin (2014-11-26 12:02:13)
> Hi all,
> 
> > this VERY POOR chip.
> As the mcp251x is voted down by the list members regularly, is there an alternative you guys would recommend?
> 
Well, sja1000 is pretty solid. They're used for example in the peak_pci.

--
Andri

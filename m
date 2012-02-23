From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [RFC/PATCH] c_can: add driver for the PCH CAN controller
Date: Thu, 23 Feb 2012 09:27:15 +0100
Message-ID: <1626144.8BPv1GvbeG@ws-stein>
References: <4F44E640.8010708@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:42626 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751065Ab2BWI1S (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 23 Feb 2012 03:27:18 -0500
In-Reply-To: <4F44E640.8010708@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Linux-CAN <linux-can@vger.kernel.org>, "bhupesh.sharma" <bhupesh.sharma@st.com>, Tomoya MORINAGA <tomoya.rohm@gmail.com>

Hello Wolfgang,

Am Mittwoch, 22. Februar 2012, 13:57:36 schrieb Wolfgang Grandegger:
> For maintenance reasons, this diver should replace the "pch_can" driver
> sooner than later as it uses the same CAN controller core. I named it
> "pch_pci". Maybe "pch_can" would be more appropriate (common). This
> patch is for 2.6.39, but likely it applies fine also to more recent
> versions of the Linux kernel.
> 
> Alexander, Tomoya, or anybody else, it would be nice if you could test
> this patch and give some feedback. Thanks.

What is the current state of c_can? Are there known bugs/issues?

Best regards,
Alexander
-- 
Dipl.-Inf. Alexander Stein

SYS TEC electronic GmbH
August-Bebel-Str. 29
D-07973 Greiz

Tel: +49-3661-6279-0, Fax: +49-3661-6279-99
eMail:    Alexander.Stein@systec-electronic.com
Internet: http://www.systec-electronic.com

Managing Director: Dipl.-Phys. Siegmar Schmidt
Commercial registry: Amtsgericht Jena, HRB 205563

From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: J1939 message length
Date: Tue, 19 May 2015 10:46:26 +0200
Message-ID: <20150519084626.GC1088@vandijck-laurijssen.be>
References: <loom.20141211T112702-791@post.gmane.org>
 <20141212110743.GC10796@vandijck-laurijssen.be>
 <6726_1418633895_548EA2A7_6726_15776_1_F1366246CF364C42B98553900CE0C5CB07FE75B7@PEXCVZYM13.corporate.adroot.infra.ftgroup>
 <20141215093136.GA646@vandijck-laurijssen.be>
 <306_1430126538_553DFFCA_306_19026_1_F1366246CF364C42B98553900CE0C5CB0801EF73@PEXCVZYM11.corporate.adroot.infra.ftgroup>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relaygateway01.edpnet.net ([212.71.1.210]:13030 "EHLO
	relaygateway01.edpnet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754524AbbESIqc (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 19 May 2015 04:46:32 -0400
Content-Disposition: inline
In-Reply-To: <306_1430126538_553DFFCA_306_19026_1_F1366246CF364C42B98553900CE0C5CB0801EF73@PEXCVZYM11.corporate.adroot.infra.ftgroup>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: pfifre.ext@orange.com
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Pascal,

I apologise for the late answer.
Your email has slipped in without drawing my attention.

Please find my answer below.

--- Original message ---
> Date: Mon, 27 Apr 2015 09:22:17 +0000
> From: pfifre.ext@orange.com
> To: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
> CC: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
> Subject: RE: J1939 message length
> 
> Hi Kurt,
> 
> I have an issue on address claim.
> 
> When I call the bind the claim address is send with a DLC of 8 and 8 bytes sent on the CAN.
> But, according to the ISO11783, I need to send and address CLAIM by a 3 bytes frame.

The "Address Claim" PGN (0x0ee00) is 8 bytes, even in iso11783.
I think you refer to the "Request for address claimed" PGN, which is 3 bytes,
with PGN 0x0ea00, and payload 00ee00.

> 
> How can, I do that with existing kernel J1939 stack or where I can modify this?
You can just send a 3 byte message with send(SOCK, <DATA>, 3, 0)

If you want to do the address claiming,
then you may take a look at jacd, a j1939 adddress claim daemon.
It does all the userspace handling necessary for address claiming.
You can find it at https://github.com/kurt-vd/can-utils.git, in j1939-v6 branch.

Kind regards,
Kurt

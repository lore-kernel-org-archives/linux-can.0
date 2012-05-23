From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [Socketcan-users] AM335x CAN/D_CAN
Date: Wed, 23 May 2012 06:56:36 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13E9C2E10@DBDE01.ent.ti.com>
References: <CAHvj1qbb9YJSBLZc1bG6MpEJcjPUtr+37wn3iJUNm_OmpH2SgA@mail.gmail.com>
 <4FBBE272.5020807@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58347 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932091Ab2EWG4m convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 23 May 2012 02:56:42 -0400
In-Reply-To: <4FBBE272.5020807@grandegger.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, bruce bushby <bruce.bushby@gmail.com>
Cc: Linux-CAN <linux-can@vger.kernel.org>

Hi Wolfgang,

On Wed, May 23, 2012 at 00:31:06, Wolfgang Grandegger wrote:
> Hello,
> 
> I switched the discussion to the new Linux-CAN mailing list.
> 
> On 05/22/2012 05:50 PM, bruce bushby wrote:
> > Greetings
> > 
> > I'm hoping a list member would be so kind as to offer some basic
> > explanations of how one would use the CAN bus provided by AM335x. I
> > understand Linux, but struggle with electronics.
> > 
> > I have read this discussion: http://comments.gmane.org/gmane.linux.can/1142
> > What is the difference between C_CAN and D_CAN?
> 
> As I see it, the D_CAN is a more advanced variant of the C_CAN
> controller. See also:
> 
> http://www.semiconductors.bosch.de/en/ipmodules/can/canipmodules/c_can/c_can.asp
> http://www.semiconductors.bosch.de/en/ipmodules/can/canipmodules/d_can/d_can.asp
> 
> Patches to add D_CAN support to the Linux-CAN C_CAN driver have been
> posted recently for mainline inclusion and are currently reviewed.

Is there a possibility of pushing my driver into 3.5 kernel?

Regards
AnilKumar

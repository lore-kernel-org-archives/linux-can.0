From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [RFC v3] CAN FD support
Date: Tue, 15 May 2012 16:16:35 +0200
Message-ID: <4FB26543.5070002@hartkopp.net>
References: <4FAD5A04.2030108@hartkopp.net> <20120514093630.GA600@vandijck-laurijssen.be> <4FB16213.2000007@hartkopp.net> <20120515083454.GA504@vandijck-laurijssen.be> <4FB21FA5.8080807@hartkopp.net> <20120515100318.GG504@vandijck-laurijssen.be> <4FB253A8.3090500@hartkopp.net> <20120515133710.GA1414@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:59871 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754845Ab2EOOQe (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 15 May 2012 10:16:34 -0400
Received: from [192.168.178.40] (p5B0B1336.dip0.t-ipconnect.de [91.11.19.54])
	by smtp.strato.de (jorabe mo79) (RZmta 29.7 DYNA|AUTH)
	with ESMTPA id m03f03o4FDiCNc for <linux-can@vger.kernel.org>;
	Tue, 15 May 2012 16:16:32 +0200 (CEST)
In-Reply-To: <20120515133710.GA1414@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 15.05.2012 15:37, Kurt Van Dijck wrote:

> On Tue, May 15, 2012 at 03:01:28PM +0200, Oliver Hartkopp wrote:

>>>>
>>>> I have a patch for that later in this mail.
>>> waaw. You're running _with_ HDR bit on :-) ?
>>
> I meant you have a "High data rate" yourself. It was meant as some form
> of humor to indicate my supprise of you generating a new patch very quick ...


Ah - ok :-)

Indeed i'm on vacancy this week and my wife pimps her garden so i need to
surveillance the dog in the house  8-)


>> There's no reason to provide a CAN_MTU frame to a CANFD application once the
>> driver is switched to CANFD-mode.
> I think there is a reason. If a CAN2.0B frame was on the wire, generating
> a can_frame rather than a canfd_frame better reflects what was on the wire.
> 
> I still think a can_frame & canfd_frame with same data differ on the wire.


Yes. But you can express this difference with the CANFD_NOEDL bit in
canfd_frame.flags:

CANFD_NOEDL == 1 => standard CAN 2.0B frame
CANFD_NOEDL == 0 => CAN FD frame (whatever DLC 0-F is used)

The distinction of this bit is only relevant to CANFD aware apps anyway.

>> Thanks to you! I was not really happy with the hard exclusive-or switch and
>> your remarks made me thinking about the simultaneous access with new and
>> legacy apps again.
> You're not tired of me then :-)


No. You are sometimes pretty brutal with your suggestions which makes me wake
up from sleep. ;-)

>> I think cutting the canfd_frames down to can_frames when
>> the content is generally usable for the legacy app makes the migration pretty
>> handy :-)
> My first suggestion was to also cut longer CANFD frames down to 8 bytes
> (thereby loosing data!).
> Remember it's still a compatibility mode. I think that would be acceptable.


At the point where CAN FD frames with a DLC > 8 become relevant for
applications a new CANFD aware application *should* come into service.

Silently cutting payload data is a bad idea.

Regards,
Oliver

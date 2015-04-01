From: Dan Egnor <dan.egnor@gmail.com>
Subject: Re: Fwd: Querying current =?utf-8?b?dHhfcXVldWU=?= usage of a SocketCAN interface
Date: Wed, 1 Apr 2015 20:57:40 +0000 (UTC)
Message-ID: <loom.20150401T225437-75@post.gmane.org>
References: <CAE+ymru296P+LjkT7_ONVc2OGMP9mtXW46Nq5aSnm1etauj9Aw@mail.gmail.com> <CAE+ymrt-rsXgteuDCvp27BSsQRE5APGDsgsSPhg31Qz3_qZEdQ@mail.gmail.com> <55187FF1.7020701@optusnet.com.au> <CAE+ymrsiE39R2ssXeorAoHuSVFdkLeV7oS-ajTLWDs46iADsYw@mail.gmail.com> <5519E5A9.7080104@optusnet.com.au> <CAE+ymrvvqL_o3ZTWdq96kQmMe6c3OzqM+SQN3qPpyH1dLMjmrw@mail.gmail.com> <551A0FF3.4070400@optusnet.com.au> <CAE+ymrt9gfCDEyNNz-b2gOS0NJt=pupm=t3HqbGosbKBC5wa7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:53627 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751158AbbDAVAI (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 1 Apr 2015 17:00:08 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1YdPk2-0006x8-QF
	for linux-can@vger.kernel.org; Wed, 01 Apr 2015 23:00:03 +0200
Received: from 216.239.45.65 ([216.239.45.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 01 Apr 2015 23:00:02 +0200
Received: from dan.egnor by 216.239.45.65 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 01 Apr 2015 23:00:02 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Paarvai Naai <opensource3141 <at> gmail.com> writes:
> I have a suspicion that SocketCAN implementations are not careful
> about doing this, even though particular controllers may support this
> type of re-prioritization of frames (with their own internal TX
> queues).

Actually I think this is a problem even if you have one process -- a higher 
priority message can get stuck behind a lower priority message (priority 
inversion).

Is there any way to deal with this, assuming that one node wants to send both 
high priority and low priority messages? There must be a solution, otherwise 
half the point of CAN (prioritized messages) would be lost...!

-- egnor


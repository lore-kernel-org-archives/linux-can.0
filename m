From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: pch_can: Data transmission stops after dropped packet
Date: Wed, 21 Nov 2012 20:48:50 +0100
Message-ID: <50AD3022.60301@grandegger.com>
References: <loom.20121114T160521-534@post.gmane.org> <50A4972A.9070707@hartkopp.net> <50A4EA87.9020206@grandegger.com> <loom.20121115T171319-854@post.gmane.org> <50A55C65.2020003@grandegger.com> <loom.20121115T222748-977@post.gmane.org> <50A95FC1.3050907@grandegger.com> <loom.20121119T155735-163@post.gmane.org> <50AA4FB3.7070009@grandegger.com> <loom.20121119T171647-35@post.gmane.org> <50AA5EE6.6060105@grandegger.com> <loom.20121119T183819-427@post.gmane.org> <50AA86DB.7000506@grandegger.com> <loom.20121119T211403-520@post.gmane.org> <50AAA8C8.2080504@grandegger.com> <loom.20121120T151831-134@post.gmane.org> <50ABABDE.8060503@grandegger.com> <loom.20121120T192159-770@post.gmane.org> <50ABF09C.8040303@grandegger.com> <50ACABE2.2020306@grandegger.com> <loom.20121121T162041-774@post.gmane.or
 g> <50ACF9C0.8050206@grandegger.com> <loom.20121121T170446-911@post.gmane.org> <50AD042B.3020305@grandegger.com> <CABgkGoERKCNNb2V8UwNMJzm0hHiZkzXBmbdAg4N556Pb2nO5LQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:59028 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755818Ab2KUTsx (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 21 Nov 2012 14:48:53 -0500
In-Reply-To: <CABgkGoERKCNNb2V8UwNMJzm0hHiZkzXBmbdAg4N556Pb2nO5LQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Casper Mogensen <casper.mogensen@gmail.com>
Cc: Michael Pellegrini <mikep86@gmail.com>, linux-can@vger.kernel.org

On 11/21/2012 05:58 PM, Casper Mogensen wrote:
> Hi again
> 
> Just took a quick look in the C_CAN driver  and from what i can see,
> it suffers from the same problem, as i described earlier with the
> pch_can.
> There is no locking what so ever, but the xmit function and the
> can_do_tx uses same place in ram buffer, and uses same procedure as in
> pch_can with setting registers and then writing them at the end of
> both functions.

I just started to have a closer look. Yes, that looks racy. I'm going to
prepare an updated driver.

Wolfgang.

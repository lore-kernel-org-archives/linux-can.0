From: Bhupesh SHARMA <bhupesh.sharma@st.com>
Subject: RE: pch_can: Data transmission stops after dropped packet
Date: Mon, 26 Nov 2012 11:33:25 +0800
Message-ID: <D5ECB3C7A6F99444980976A8C6D896384FB4958C03@EAPEX1MAIL1.st.com>
References: <loom.20121114T160521-534@post.gmane.org>
 <50AA4FB3.7070009@grandegger.com> <loom.20121119T171647-35@post.gmane.org>
 <50AA5EE6.6060105@grandegger.com> <loom.20121119T183819-427@post.gmane.org>
 <50AA86DB.7000506@grandegger.com> <loom.20121119T211403-520@post.gmane.org>
 <50AAA8C8.2080504@grandegger.com> <loom.20121120T151831-134@post.gmane.org>
 <50ABABDE.8060503@grandegger.com> <loom.20121120T192159-770@post.gmane.org>
 <50ABF09C.8040303@grandegger.com> <50ACABE2.2020306@grandegger.com>
 <loom.20121121T160744-278@post.gmane.or  g> <loom.20121121T162041-774@p
  ost.gmane.org> <50ACF9C0.8050206@grandegger.com>
 <loom.20121121T170446-911@post.gmane.org> <50AD042B.3020305 @grandegger.com>
 <loom.20121121T184014-391@post.gmane.org> <50AD319E.2000209@grandegger.com>
 <loom.20121121T215717-106@post.gmane.org>
 <loom.20121123T150627-133@post.gmane.org> <50AF8C01.6060809@grandegger.com>
 <loom.20121123T155746-12@post.gmane.org> <50AFABB1.7080507@grandegger.com>
 <50B0743A.4080203@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from eu1sys200aog114.obsmtp.com ([207.126.144.137]:51440 "EHLO
	eu1sys200aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753853Ab2KZDdi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Sun, 25 Nov 2012 22:33:38 -0500
In-Reply-To: <50B0743A.4080203@grandegger.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Michael Pellegrini <mikep86@gmail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Wolfgang,

> -----Original Message-----
> From: Wolfgang Grandegger [mailto:wg@grandegger.com]
> Sent: Saturday, November 24, 2012 12:46 PM
> To: Michael Pellegrini
> Cc: linux-can@vger.kernel.org; Bhupesh SHARMA
> Subject: Re: pch_can: Data transmission stops after dropped packet
> 
> On 11/23/2012 06:00 PM, Wolfgang Grandegger wrote:
> > On 11/23/2012 04:04 PM, Michael Pellegrini wrote:
> >> Wolfgang Grandegger <wg <at> grandegger.com> writes:
> >>
> >>> Did you see any other related kernel messages? For real testing you
> >>> should remove the debug message above. I will try to add a more
> >>> sophisticated trigger.
> >>
> >> I didn't see any other messages.  That message prints in such a tight
> >> loop that it's hard to catch any other messages.
> >
> > That's clear. Therefore please remove that printk for testing. For a
> > quick test could you please add spin_locks to c_can_do_rx_poll()
> > similar to c_can_do_tx(). My suspicion is that there is a race in
> > accessing the message ram. There is this infamous
> > c_can_msg_obj_is_busy() in
> > c_can_object_get() and c_can_object_put().
> 
> At a closer look I realized that the c_can driver uses IF1 for both, RX and TX.
> The manual recommends to use one IF for RX and the other for TX to avoid
> conflicts between the CPU access to the message RAM. I see this
> implemented in the pch_can driver but not the c_can driver. Bhupesh, any
> comments? Maybe I have missed something.
> 

Yes, at the moment the C_CAN driver code uses only IF1 for both Tx and Rx purposes.
It was on my To-Do list but I got moved to some other project, so wasn't able to work on this topic.

However, the changes are very easy and I will try to work on the same and circulate
some patches by early December. In the meanwhile if someone else has some time and
a C_CAN platform to test the patches, I will be more than happy :)

Regards,
Bhupesh

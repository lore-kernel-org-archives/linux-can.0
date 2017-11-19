From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: Request-for-testing: j1939
Date: Sun, 19 Nov 2017 20:04:44 +0100
Message-ID: <20171119190444.GA14089@airbook.vandijck-laurijssen.be>
References: <20171105210934.GC21581@airbook.vandijck-laurijssen.be>
 <CAHChkruE=zEM2bq98GfoZUGO=SbLK-BzmLTgm-29UDn9g3MLdg@mail.gmail.com>
 <CAHChkrvWBKCe8-3hG3izu5NJr=TY+JYoJyRpLuOAJWQe+oEYzA@mail.gmail.com>
 <20171110144217.GB12963@airbook.vandijck-laurijssen.be>
 <CAHChkrt784L417Rqe0oaMpw-iWAo38W+U6T_-21XyN=+YL2Adg@mail.gmail.com>
 <20171111121758.GD12963@airbook.vandijck-laurijssen.be>
 <CAHChkrtYsKLycGXuH3NNJqMsWAGUUczyLgUJXuS5SqC7AgyDjA@mail.gmail.com>
 <20171114085940.GA14187@airbook.vandijck-laurijssen.be>
 <CAHChkrtzu4seVRahbqTFGiEpOof2LZh=mP7G4v_SZFvfzg=O8w@mail.gmail.com>
 <20171116084746.GA6974@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b02.edpnet.be ([212.71.1.222]:49983 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751015AbdKSTEt (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 19 Nov 2017 14:04:49 -0500
Content-Disposition: inline
In-Reply-To: <20171116084746.GA6974@airbook.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Elenita Hinds <ecathinds@gmail.com>, linux-can@vger.kernel.org, David Jander <david@protonic.nl>

Marc,

I pushed another commit to my github repository, that fixes the
transport protocol behaviour when the local j1939 node is not
participating.

Kurt


> > I pulled in commit a9ca675 and re-tested -- works!
> 
> Great. I'm glad we found this.
> 
> It seems that the problem existed for quite some time.
> Since we passed an ISOBUS certification with an early prototype of this
> stack, I'm sure it went wrong afterwards some time ... but its getting
> too complicated to retrieve due to the out-of-tree existance of the
> stack :-(
> 
> > I was going to post
> > in the linux-can mail about when the timeframe of merging J1939 in the
> > linux mainline.
> 
> Yep, please share your findings on the linux-can mailing list.
> 
> > 
> > I have started to re-test address claiming and transmissions next.
> > 
> > One question - what is the significance of J1939_IDLE_ADDR (0xfe)? Is
> > this address specified in the J1939 spec (I can't find it).
> 
> 0xfe is to be used when an ecu was not able to claim an address.
> It can be anybody, and it is used by multiple ecu's, just to participate
> in the necessary network management communication.
> 
> > 
> > Thanks!
> > 
> > --elenita
> > 
> > On Tue, Nov 14, 2017 at 2:59 AM, Kurt Van Dijck
> > <dev.kurt@vandijck-laurijssen.be> wrote:
> > > Bravo,
> > >
> > > I think you pointed the right spot.
> > > I'm still looking why it got wrong like that,
> > > in the meanwhile, I pushed a fix in my github repository.
> > >
> > > I found a second similar problem.
> > >
> > > Kurt
> > >
> > >>
> > >> Replies below ...
> > >>
> > >> >I'm curious about the result.
> > >>
> > >> So adding more logging, "priv->ents[cb->addr.da].nusers" is always 0
> > >> (not set at all), as expected since the user space program is not
> > >> claiming any address. But in j1939_can_recv() of main.c,
> > >> skcb->dst_flags is being set to 1 for ECU_LOCAL. See log excerpt
> > >> below:
> > >>
> > >> [  103.744765] can_j1939: j1939sk_bind: j1939_name_local_get name=0
> > >>              <== No name, nusers not set
> > >> [  103.744827] can_j1939: j1939sk_bind: j1939_addr_local_get sa=255
> > >>                 <== No addr claimed, nusers not set
> > >> [  104.135692] j1939_can_recv: da=132 nusers=0 prev_dstflags=0
> > >> curr_dstflags=1  <== Multiframe, curr_dstflags should be 0, not 1
> > >> [  104.136966] j1939_can_recv: da=28   nusers=0 prev_dstflags=0
> > >> curr_dstflags=1  <== Multiframe, curr_dstflags should be 0, not 1
> > >> [  104.174357] j1939_can_recv: da=255 nusers=0 prev_dstflags=0
> > >> curr_dstflags=0  <== Multiframe, curr_dstflags=0 is good
> > >>
> > >> (Note: 'da' contains 'skcb->addr.da' value, 'nusers' =>
> > >> 'priv->ents[skcb->addr.da].nusers', '*_dstflags' => 'skcb->dst_flags'
> > >> before and after.)
> > >>
> > >> So a response transmission is attempted even though the destination
> > >> address is not claimed locally because j1939tp_im_receiver() was
> > >> returning 1.
> > >>
> > >> The problem could be the 'if' condition in lines 105-107 of main.c,
> > >> j1939_can_recv():
> > >> if (j1939_address_is_valid(skcb->addr.da) ||
> > >>     (j1939_address_is_unicast(skcb->addr.da) &&
> > >>      priv->ents[skcb->addr.da].nusers))
> > >>
> > >> As long as skcb->addr.da is not 255, the above logic will always
> > >> return true since j1939_address_is_valid() returns True and the rest
> > >> of the check is skipped because of the OR.
> > >>
> > >> Should the check be something like:
> > >> if ( (j1939_address_is_valid(skcb->addr.da) ||
> > >>       j1939_address_is_unicast(skcb->addr.da))  &&
> > >>       (priv->ents[skcb->addr.da].nusers) )
> > >>
> > >> or
> > >>
> > >> if (  j1939_address_is_valid(skcb->addr.da) &&
> > >>       j1939_address_is_unicast(skcb->addr.da) &&
> > >>       priv->ents[skcb->addr.da].nusers  )
> > >> ??
> > >>
> > >> Actually, is there a need to call j1939_address_is_valid()? DA=255 is
> > >> not allowed for RTS/CTS data transfers anyway and
> > >> j1939tp_im_receiver() is only called for RTS/CTS transmissions as far
> > >> as I can tell.
> > >>
> > >> >I figured now that I the can-j1939 node tries to participate in the
> > >> >replayed transport sessions, then 2 nodes on the CAN bus will try to
> > >> >send the same CAN id's, on a similar moment in time.
> > >> >That is not good at all, do you have bus-off recovery in place?
> > >>
> > >> Currently, only to configure the CAN interfaces to automatically
> > >> restart in case of a bus-off condition (log the error as well).
> > >>
> > >> Looking forward to more feedback.
> > >>
> > >> Thanks,
> > >> Elenita
> > >>
> > >> On Sat, Nov 11, 2017 at 6:17 AM, Kurt Van Dijck
> > >> <dev.kurt@vandijck-laurijssen.be> wrote:
> > >> >> > Do you replay the log from the same node?
> > >> >>
> > >> >> No, not the same node. The CAN frames are sent by a different node.
> > >> >> Are you familiar with PCAN devices, for example
> > >> >> https://gridconnect.com/can-usb.html? So a script running on a PC
> > >> >> sends the CAN frames through the PCAN adapter which is connected to
> > >> >> the hardware running Linux.
> > >> >
> > >> > I'm aware, I think gridconnect delivers rebranded peak can devices, see
> > >> > https://www.peak-system.com/PCAN-USB.199.0.html?L=1
> > >> >
> > >> >>
> > >> >> > Am I correct that you don't to intend to send a single j1939 frame since
> > >> >> > you replay all via a CAN_RAW socket?
> > >> >>
> > >> >> Yes. Currently, the way I'm able to test is using the test setup I
> > >> >> described above, so many frames will be sent and are captured by the
> > >> >> Linux-based hardware.
> > >> >
> > >> > I figured now that I the can-j1939 node tries to participate in the
> > >> > replayed transport sessions, then 2 nodes on the CAN bus will try to
> > >> > send the same CAN id's, on a similar moment in time.
> > >> > That is not good at all, do you have bus-off recovery in place?
> > >> >
> > >> >>
> > >> >> > You are now testing for dynamically addressed endpoints, not static ones.
> > >> >> > I think that what you try to test is already covered by 'j1939tp_im_receiver()', or it should have been covered.
> > >> >> > So the tests in j1939_can_recv (net/can/j1939/main.c) that add ECU_LOCAL are not accurate in your case,
> > >> >> > but I fail to see why.
> > >> >>
> > >> >> I looked at that part but was not quite sure about the intention of
> > >> >> ECU_LOCAL. But now, I understand -- so if no process within the device
> > >> >> claimed an address, the check "priv->ents[cb->addr.da].nusers" should
> > >> >> be 0, right?
> > >> >
> > >> > Well, ECU_LOCAL is cached copy of priv->ents[cb->addr.da].nusers, at the
> > >> > time of arrival, which is in this case not a problem.
> > >> >
> > >> >> I'll check why it is getting set.
> > >> >
> > >> > I'm curious about the result.
> > >> >
> > >> > Kurt
> > >> >
> > >> >>
> > >> >> > Maybe it helps to look to j1939_can_recv to solve your problem.
> > >> >>
> > >> >> Will do.
> > >> >>
> > >> >> Thanks, Kurt.
> > >> >>
> > >> >> --elenita
> > >> >>
> > >> >>
> > >> >> On Fri, Nov 10, 2017 at 8:42 AM, Kurt Van Dijck
> > >> >> <dev.kurt@vandijck-laurijssen.be> wrote:
> > >> >> > Hey,
> > >> >> >
> > >> >> > I remain puzzled with your setup.
> > >> >> > Do you replay the log from the same node?
> > >> >> >
> > >> >> > Am I correct that you don't to intend to send a single j1939 frame since
> > >> >> > you replay all via a CAN_RAW socket?
> > >> >> >
> > >> >> > Please also find some remarks on your hack below:
> > >> >> >
> > >> >> > --- Original message ---
> > >> >> >> Date: Mon, 6 Nov 2017 16:23:01 -0600
> > >> >> >> From: Elenita Hinds <ecathinds@gmail.com>
> > >> >> >> To: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
> > >> >> >> Subject: Re: Request-for-testing: j1939
> > >> >> >>
> > >> >> >> Hi Kurt,
> > >> >> >>
> > >> >> >> My temporary hack for the addressing issue is to create a new function
> > >> >> >> in bus.c called j1939_address_is_claimed():
> > >> >> >>
> > >> >> >> bool j1939_address_is_claimed(u8 addr, int ifindex)
> > >> >> >> {
> > >> >> >>     struct j1939_ecu *ecu = NULL;
> > >> >> >>     struct j1939_priv *priv;
> > >> >> >>     bool result = false;
> > >> >> >>
> > >> >> >>     if (!j1939_address_is_unicast(addr))
> > >> >> >>         return false;
> > >> >> >>
> > >> >> >>     priv = j1939_priv_get_by_ifindex(ifindex);
> > >> >> >>     if (!priv)
> > >> >> >>         return false;
> > >> >> >>
> > >> >> >>     read_lock_bh(&priv->lock);
> > >> >> >>     list_for_each_entry(ecu, &priv->ecus, list) {
> > >> >> >>         if (ecu->sa == addr) {
> > >> >> >>             /* Destination address claimed here */
> > >> >> >>             result = true;
> > >> >> >>             break;
> > >> >> >>         }
> > >> >> >>     }
> > >> >> >>     read_unlock_bh(&priv->lock);
> > >> >> >>
> > >> >> >>     return result;
> > >> >> >> }
> > >> >> >>
> > >> >> >>
> > >> >> >> This function is then called in transport.c, functions j1939xtp_rx_rts():
> > >> >> >>
> > >> >> >> if (j1939tp_im_receiver(session->skb))  {
> > >> >> >>         // TEST: Check if claimed by this device
> > >> >> >>         bool isClaimed = j1939_address_is_claimed(cb->addr.da,
> > >> >> >> session->skb->dev->ifindex);
> > >> >> >>         if ( (extd || (tp_cmd_bam != dat[0])) && (isClaimed == true) )
> > >> >> >>             j1939_session_schedule_txnow(session);
> > >> >> >> }
> > >> >> >
> > >> >> > You are now testing for dynamically addressed endpoints, not static
> > >> >> > ones.
> > >> >> > I think that what you try to test is already covered by
> > >> >> > 'j1939tp_im_receiver()', or it should have been covered.
> > >> >> > So the tests in j1939_can_recv (net/can/j1939/main.c) that add ECU_LOCAL
> > >> >> > are not accurate in your case, but I fail to see why.
> > >> >> > I bet it originates from 'replaying', of which I'm sure I never tested
> > >> >> > like that :-(
> > >> >> >
> > >> >> > Maybe it helps to look to j1939_can_recv to solve your problem.
> > >> >> >
> > >> >> > Kind regards,
> > >> >> > Kurt

From: Michal Kubecek <mkubecek@suse.cz>
Subject: Re: [PATCH] can: gw: ensure DLC boundaries after CAN frame
 modification
Date: Thu, 3 Jan 2019 21:33:47 +0100
Message-ID: <20190103203347.GC28932@unicorn.suse.cz>
References: <20190103122634.2530-1-socketcan@hartkopp.net>
 <20190103140121.GB28932@unicorn.suse.cz>
 <9e4dfe7c-42cc-3dba-763a-23ce4e10389b@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9e4dfe7c-42cc-3dba-763a-23ce4e10389b@hartkopp.net>
Sender: netdev-owner@vger.kernel.org
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: davem@davemloft.net, netdev@vger.kernel.org, ieatmuttonchuan@gmail.com, meissner@suse.de, linux-can@vger.kernel.org, linux-stable <stable@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

On Thu, Jan 03, 2019 at 08:31:51PM +0100, Oliver Hartkopp wrote:
> Hi Michal,
> 
> On 1/3/19 3:01 PM, Michal Kubecek wrote:
> > On Thu, Jan 03, 2019 at 01:26:34PM +0100, Oliver Hartkopp wrote:
> (..)
> > >   	/* check for checksum updates when the CAN frame has been modified */
> > >   	if (modidx) {
> > > +		/* ensure DLC boundaries after the different mods */
> > > +		if (cf->can_dlc > 8)
> > > +			cf->can_dlc = 8;
> > > +
> > >   		if (gwj->mod.csumfunc.crc8)
> > >   			(*gwj->mod.csumfunc.crc8)(cf, &gwj->mod.csum.crc8);
> > 
> > IMHO "8" should rather be "CAN_MAX_DLEN". I can see two problems with
> > your patch:
> > 
> > 1. If I understand the code correctly, canfd_frame packets (which allow
> > larger lenth) are also processed by this code path.
> 
> In fact the can-gw frame modification and checksum functionalities lack CAN
> FD support today.
> 
> If you take a look into the netlink API only struct can_frame's can be
> supplied for frame modifications - and so are the checks e.g. in
> cgw_chk_csum_parms().
> 
> The given patch fixes the problem as described in the commit message in all
> stable Linux versions since can-gw appeared in Linux 3.2.
> 
> Anyway your modification makes definitely sense, as it allows to process CAN
> FD frames in struct canfd_frame as long as only data is modified that is
> also available in a struct can_frame. AND - as a bonus - it should work for
> stable 3.2 too, when CAN FD was not even introduced. Good idea!
> 
> If it's ok for you I would like to re-send the patch together with the CVE
> number and would like to credit your suggestion in the text and with
> "Suggested-by:".

OK

> > As reported to security list, cgw_csum_xor_rel() with negative offset can
> > then rewrite e.g. frag_list pointer in skb_shared_info, crashing the
> > system. With unprivileged user namespaces, this can be exploited by any
> > regular user.
> 
> This is wrong! First there is no negative offset, as can_dlc is a u8 value.
> Therefore you can try to hit content in the tail of the skb only.

I probably didn't use the right term. By "negative offset" I meant the
value of cgw_csum_xor::result_idx which, if negative, is interpreted as
an offset relative to can_dlc. If the (invalid) value of modified
can_dlc is sufficiently large (larger then actual nskb->len), userspace
can enforce writing past packet data.

See http://bugzilla.suse.com/show_bug.cgi?id=1120386 (comment 1) for an
example which can crash unfixed kernel by rewriting a pointer in skb
shared data which is later dereferenced when the skb is freed.

> Second can-gw rules can only be configured by *root* and not by any regular
> user - and finally it is definitely not namespace related.
> 
> So the user root can configure a can-gw rule to shoot into the skb tail to
> kill the machine. I can imagine better things to do when I'm already root

Sorry for the noise, I misread the code (and commit 90f62cf30a78) so
that I thought netlink_ns_capable() is used in net/can/gw.c; now I see
that it's netlink_capable() so that global CAP_NET_ADMIN is required
rather than namespace one and the bug cannot be exploited by a regular
user.

Michal Kubecek

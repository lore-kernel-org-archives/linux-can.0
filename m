From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [RFC v2 4/7] c_can_pci: introduce board specific PCI bar
Date: Fri, 30 Nov 2012 10:11:06 +0100
Message-ID: <50B8782A.7070709@grandegger.com>
References: <1354199987-10350-1-git-send-email-wg@grandegger.com> <1354199987-10350-5-git-send-email-wg@grandegger.com> <50B8723D.4080300@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:48741 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888Ab2K3JLP (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 30 Nov 2012 04:11:15 -0500
In-Reply-To: <50B8723D.4080300@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, bhupesh.sharma@st.com, tomoya.rohm@gmail.com

On 11/30/2012 09:45 AM, Marc Kleine-Budde wrote:
> On 11/29/2012 03:39 PM, Wolfgang Grandegger wrote:
>> Also fix minor issue with pci_iomap specifying size 0 for
>> mapping the full range.
> 
> If I understand the code correct, using pci_resource_len(pdev, 0) for
> the max len (of BAR 0) instead of 0 isn't a bug, it's just more
> complicated than it needs to be. If it really is a bug, I think a
> separate patch will be good.

It's a minor issue, not a bug. Both do the same thing. See:

http://lxr.linux.no/#linux+v3.6.8/lib/pci_iomap.c#L23

Wolfgang.

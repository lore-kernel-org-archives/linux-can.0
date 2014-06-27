From: Jason R1 White <White_Jason_R1@cat.com>
Subject: Re: Bus off
Date: Fri, 27 Jun 2014 10:22:00 -0500
Message-ID: <OF8D65BB4D.F92B928C-ON86257D04.00546246-86257D04.0054697F@notes.cat.com>
References: <CANGgnMZyG1UDVigM-68tu27=oNYfaw0OWxCv4uT+NfN4v=vm2A@mail.gmail.com> <20140627050512.GA1291@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from imail02.cis.cat.com ([12.2.142.8]:28556 "EHLO
	imail01.cis.cat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754064AbaF0PWE (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 27 Jun 2014 11:22:04 -0400
In-Reply-To: <20140627050512.GA1291@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org, linux-can-owner@vger.kernel.org

> 
> On Thu, Jun 26, 2014 at 10:13:17AM -0700, Austin Schuh wrote:
> > Does anyone know if the TX queues are cleared on BUS-OFF?
> 
> No queues are emptied, you will only loose the curent pending 
transmission.
> 
> > 

I thought the restart mechanism flushed the transmit queues (ip link set 
can0 type can restart).  Is this not the case?  That is what we are 
relying upon.  We used to close and open the interface explicitly. 

For controls its not a good practice to let stale data sit in the output 
buffer. 

Jason 

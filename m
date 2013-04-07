From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: Losing CAN messages with socket-CAN
Date: Sun, 7 Apr 2013 21:05:11 +0000
Message-ID: <20130407210511.GA853@vandijck-laurijssen.be>
References: <20130405133140.17A179B5161E0@bmail04.one.com>
 <516170F7.5040400@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay010.isp.belgacom.be ([195.238.6.177]:9065 "EHLO
	mailrelay010.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934308Ab3DGVFV (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 7 Apr 2013 17:05:21 -0400
Content-Disposition: inline
In-Reply-To: <516170F7.5040400@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: "j.p.lammertink" <j.p.lammertink@kubicas.com>, linux-can@vger.kernel.org

On Sun, Apr 07, 2013 at 03:13:27PM +0200, Wolfgang Grandegger wrote:
> Hi Jeroen,
> 
> On 04/05/2013 03:31 PM, j.p.lammertink wrote:
> > Hi Wolfgang,
> > 
[...]
> > Unfortunatelly, running the test application resulted in an assert. To obtain
> > additional information I addapted the function CCanPort::Write() (See below).
> > Running gave the following result:
> > 
> > write returned -1
> > errno = 64
> > CCanPort.cpp[116]: ASSERT(ret == sizeof(*pFrame)) FAILED 
> > 
> > The errno 64 is not mentioned in man write
> > #define ENONET 64 /* Machine is not on the network */
> 
> Hm, I'm also puzzled where this errno comes from?

	$ man 3 errno
says:
       A common mistake is to do

           if (somecall() == -1) {
               printf("somecall() failed\n");
               if (errno == ...) { ... }
           }

Maybe the real errno is overwritten already by the time it's actually used?

Kurt

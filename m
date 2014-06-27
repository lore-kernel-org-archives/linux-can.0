From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Bus off
Date: Fri, 27 Jun 2014 17:35:39 +0200
Message-ID: <53AD8F4B.7090900@grandegger.com>
References: <CANGgnMZyG1UDVigM-68tu27=oNYfaw0OWxCv4uT+NfN4v=vm2A@mail.gmail.com> <20140627050512.GA1291@vandijck-laurijssen.be> <OF8D65BB4D.F92B928C-ON86257D04.00546246-86257D04.0054697F@notes.cat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:35314 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753976AbaF0Pn5 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 27 Jun 2014 11:43:57 -0400
In-Reply-To: <OF8D65BB4D.F92B928C-ON86257D04.00546246-86257D04.0054697F@notes.cat.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Jason R1 White <White_Jason_R1@cat.com>, linux-can@vger.kernel.org, linux-can-owner@vger.kernel.org

On 06/27/2014 05:22 PM, Jason R1 White wrote:
>>
>> On Thu, Jun 26, 2014 at 10:13:17AM -0700, Austin Schuh wrote:
>>> Does anyone know if the TX queues are cleared on BUS-OFF?
>>
>> No queues are emptied, you will only loose the curent pending 
> transmission.
>>
>>>
> 
> I thought the restart mechanism flushed the transmit queues (ip link set 
> can0 type can restart).  Is this not the case?  That is what we are 
> relying upon.  We used to close and open the interface explicitly. 


"restart" and "restart-ms" should trigger a bus-off recovery:

http://lxr.free-electrons.com/source/Documentation/networking/can.txt#L1087

> 
> For controls its not a good practice to let stale data sit in the output 
> buffer. 

The intention of restart(-ms) was to simply trigger a bus-off recovery.
The name is not well chosen, though.

Wolfgang.

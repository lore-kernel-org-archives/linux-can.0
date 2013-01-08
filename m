From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: exclusive access to can interface
Date: Tue, 08 Jan 2013 11:08:36 +0100
Message-ID: <50EBF024.1030507@grandegger.com>
References: <2412937.XVpYjfC7zz@ws-stein> <50EB10F4.6070308@pengutronix.de> <2293513.Wi876mfY7y@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:33668 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755138Ab3AHKIq (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 Jan 2013 05:08:46 -0500
In-Reply-To: <2293513.Wi876mfY7y@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On 01/08/2013 10:23 AM, Alexander Stein wrote:
> Hello Marc,
> 
> On Monday 07 January 2013 19:16:20, Marc Kleine-Budde wrote:
>> On 01/07/2013 05:52 PM, Alexander Stein wrote:
>>> is there a way to get exclusive (write) access to a CAN interface, so
>>> that only one bound socket can write CAN frames on the bus?
>>
>> No, what's the use case?
> 
> This was a customers request in order to prevent multiple applications (or 
> instances) to send CAN frames on a specific CAN interface at the same time 
> with the very same CAN-IDs. Concurrent reads shall still be allowed!

Application == CANopen?! It's like giving exclusive access to a network
device. Isn't that possible? Well, at a first glance I have not found
anything like that.

Wolfgang.


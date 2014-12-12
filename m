From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: J1939 message length
Date: Fri, 12 Dec 2014 12:07:43 +0100
Message-ID: <20141212110743.GC10796@vandijck-laurijssen.be>
References: <loom.20141211T112702-791@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relaygateway02.edpnet.net ([212.71.1.211]:29855 "EHLO
	relaygateway02.edpnet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965845AbaLLLYH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 12 Dec 2014 06:24:07 -0500
Content-Disposition: inline
In-Reply-To: <loom.20141211T112702-791@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: pascal <pfifre.ext@orange.com>
Cc: linux-can@vger.kernel.org

Hey Pascal,

On Thu, Dec 11, 2014 at 10:44:39AM +0000, pascal wrote:
> Hi,
> 
> I've installed the patch for using j1939 socket CAN under linux 
> (beagleBone black).
> 
> It works fine for receiving j1939 message and sending short message (8 
> bytes max).
> 
> But when I try to send long message (>8 bytes long), but the message has 
> not been sent.

Ok.
You provide little info how you detect that <=8 bytes work, and >8 bytes do not work.

What do you see on the (raw) CAN bus?

Are you aware of the Transport Protocol on J1939 that delivers messages >8 bytes?

Kurt
> 
> I use the sendTo method to send frame.
> 
> Do I have to do something special to send long message?

no, not necessarily.

> I'm working with a 3.8.13 kernel on beaglebone black.

Kind regards,
Kurt

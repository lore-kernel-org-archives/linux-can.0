From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: J1939 support issiues
Date: Fri, 16 May 2014 16:14:41 +0200
Message-ID: <20140516141441.GA13182@vandijck-laurijssen.be>
References: <CAJdBzeAkxtQKTcr863OJiLJkXyOOxTn-eEEUbCirA7gbQ95kYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay007.isp.belgacom.be ([195.238.6.173]:39571 "EHLO
	mailrelay007.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756519AbaEPOOq (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 16 May 2014 10:14:46 -0400
Content-Disposition: inline
In-Reply-To: <CAJdBzeAkxtQKTcr863OJiLJkXyOOxTn-eEEUbCirA7gbQ95kYQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Timothy Vieregge <tvieregge@clearpathrobotics.com>
Cc: linux-can@vger.kernel.org

Hey,

On Thu, May 15, 2014 at 04:00:22PM -0400, Timothy Vieregge wrote:
> I'm trying to get J1939 support for an Ubuntu machine, and I'm running
> into some issues.
> 
> When I try to compile the can-j1939-utils (against ubuntu-lts-3.8
> kernel) I am getting an error.
> 
> "libj1939.h:3:29 fatal error: linux/can/j1939.h: No such file or directory"

The file include/linux/can/j1939.h should be in your can-j1939-utils repository.
Can you verify?

> 
> I can see the file in the the linux-can-j1939 repo, but not in my
> merged source, or in /usr/include on the target machine. Any idea
> what's going wrong?

Maybe your host system does not want to look in ./include
directory for system include files.
Can you grab the command that your build process executes?

Kind regards,
Kurt

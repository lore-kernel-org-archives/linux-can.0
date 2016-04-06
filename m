From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: J1939 Linux
Date: Wed, 6 Apr 2016 09:46:53 +0200
Message-ID: <20160406074653.GA28692@airbook.vandijck-laurijssen.be>
References: <loom.20160405T174008-515@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b01.edpnet.be ([212.71.1.221]:50784 "EHLO
	relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754158AbcDFIJZ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 6 Apr 2016 04:09:25 -0400
Content-Disposition: inline
In-Reply-To: <loom.20160405T174008-515@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Dinesh <dinesh.velayutham@lnttechservices.com>
Cc: linux-can@vger.kernel.org

Hey,

> 
> Hi,
> I am trying to merge J1939 to linux kernel 3.19.0.52. I download the linux
> kernel git repo and added linux-can-j1939.git as remote repo. I am trying to
> fetch and facing errors as "certificate verification failed".
> 
> 1. git clone git://kernel.ubuntu.com/kernel-ppa/mirror/ubuntu-vivid.git
> 2. git remote add j1939 http://gitorious.org:linux-can/linux-can-j1939.git

gitorious.org has stopped.
I moved my can-j1939 repositories to https://github.com/kurt-vd/linux.
You would find this reference on http://elinux.org/J1939.
Where did you find the reference to gitorious.org?
I may have forgotten to update a link.

> 3. git remote update j1939
> Fetching j1939
> fatal: unable to access 'https://gitorious.org/linux-can-j1939.git/': server
> certificate verification failed. CAfile: /etc/ssl/certs/ca-certificates.crt
> CRLfile: none
> error: Could not fetch j1939
> 

Kind regards,
Kurt

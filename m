From: Dinesh <dinesh.velayutham@lnttechservices.com>
Subject: J1939 Linux
Date: Tue, 5 Apr 2016 15:43:39 +0000 (UTC)
Message-ID: <loom.20160405T174008-515@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:41021 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759382AbcDEPzY (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 5 Apr 2016 11:55:24 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1anTJo-0006Rh-FO
	for linux-can@vger.kernel.org; Tue, 05 Apr 2016 17:55:04 +0200
Received: from 207-179-201-7.mtco.com ([207.179.201.7])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 05 Apr 2016 17:55:04 +0200
Received: from dinesh.velayutham by 207-179-201-7.mtco.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 05 Apr 2016 17:55:04 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi,
I am trying to merge J1939 to linux kernel 3.19.0.52. I download the linux
kernel git repo and added linux-can-j1939.git as remote repo. I am trying to
fetch and facing errors as "certificate verification failed".

1. git clone git://kernel.ubuntu.com/kernel-ppa/mirror/ubuntu-vivid.git
2. git remote add j1939 http://gitorious.org:linux-can/linux-can-j1939.git
3. git remote update j1939
Fetching j1939
fatal: unable to access 'https://gitorious.org/linux-can-j1939.git/': server
certificate verification failed. CAfile: /etc/ssl/certs/ca-certificates.crt
CRLfile: none
error: Could not fetch j1939

Regards
Dinesh



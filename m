Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821F32931FC
	for <linux-can@vger.kernel.org>; Sat, 25 Jul 2026 12:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784983237; cv=none; b=RZs3EErUYG97hqFUY04qebZ9PRQxQ9rf10CfI5XQS/Yzrj+Bg52Pf5SQFrP9zybLuQM1Crhplh1nrFki0TlGF86/oUt0FwwoXkS2wUHhpQTc77SCnlD3W2npijV82Wvox7JKV7IBodp9DQHqCBjEd00ejtzrbDiQ7nORydx/kVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784983237; c=relaxed/simple;
	bh=XipGNt4Z+Dge6vmWRcoltCFBNRYVLXA4JuqVuYW3Njs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JP8VuMD/wpJvS5Q/oPr1AemxQ20aRLnvyNY2aDAq1mNOV7Jz4poPCY8h4SzW8DKTuVttXFKT5vDzEHO7h7ELjfxVwn96X+Y+zcRvUMFRBQZclT3oKxoYZ+g0ogr4cFpoM3ejmZDra+qib5/h4HJz/XeWEeGOLCaAK4z6D+eYOIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 66PCe5Wd037892;
	Sat, 25 Jul 2026 21:40:05 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 66PCe528037889
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 25 Jul 2026 21:40:05 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <25ea4702-6198-4cf3-b2ab-ef2865cb1177@I-love.SAKURA.ne.jp>
Date: Sat, 25 Jul 2026 21:40:04 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 (repost)] can: j1939: use netdevice_tracker for
 j1939_{priv,session,ecu} tracking
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: linux-can@vger.kernel.org, Robin van der Gracht <robin@protonic.nl>,
        kernel@pengutronix.de, Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>
References: <2bc332e0-b250-4679-a075-1c413ad843ce@I-love.SAKURA.ne.jp>
 <akZt7t2aLfnf1Yk6@pengutronix.de>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <akZt7t2aLfnf1Yk6@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav105.rs.sakura.ne.jp

On 2026/07/02 22:55, Oleksij Rempel wrote:
> On Fri, May 29, 2026 at 10:31:22AM +0900, Tetsuo Handa wrote:
>> syzbot is still reporting
>>
>>   unregister_netdevice: waiting for vcan0 to become free. Usage count = 2
>>
>> problem. A debug printk() patch in linux-next-20260508 identified that
>> there is dev_hold()/dev_put() imbalance in j1939_priv management.
>>
(...snipped...)
>>
>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> 
> Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
> 

Who is supposed to send this patch to linux-next.git tree?


Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DFB270575
	for <linux-can@vger.kernel.org>; Tue, 19 May 2026 02:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779157396; cv=none; b=VNgHpMOLsLXDA5U8GXxKAp2VvhAbjnkazcCoXJqeo7Ya95WY/yzLf0Sv0W5LscfK3l8Enbzmk1ICs+QtT913Tmh0gOxx8lf6epSFvxUYlrG+n+k52t21ExfroIAj7Xp7fsIOlCYvaNwbOmWDk1dr5vtFUtaGIB59yucPIKbgqQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779157396; c=relaxed/simple;
	bh=b+UuQr7kjG0oQaE8CpTkSSsNrYUp+abjHnMU/Bi8MSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cUzyoXhJNKdXPlYvN+qiPIJenplZCx/b/maPOeir4Tni6ZmHaPpzOhTzm8ym0OP7/O8IHjeyhRjibwjy6IlkDgjzawz/2tOuP0/H29SJhGSTg2IlptAIgV0gqyz7q0BxcDoyrh9Xmsv0UjXXVseu8zyFQsONlkk4mHL//RovOss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 64J2MlCc052543;
	Tue, 19 May 2026 11:22:47 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.5] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 64J2MlE7052540
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 19 May 2026 11:22:47 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <7bdea3af-647f-4301-b9cb-3b8a75dc76a6@I-love.SAKURA.ne.jp>
Date: Tue, 19 May 2026 11:22:44 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] can: j1939: use netdevice_tracker for
 j1939_{priv,session,ecu} tracking
To: Jakub Kicinski <kuba@kernel.org>
Cc: Robin van der Gracht <robin@protonic.nl>,
        Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>
References: <c109e9fc-3fb7-4a48-a0bd-a4d7663e7342@I-love.SAKURA.ne.jp>
 <ef62371e-ddd5-4074-b554-410c708ca1cd@I-love.SAKURA.ne.jp>
 <20260518190455.7fe355b4@kernel.org>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20260518190455.7fe355b4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav102.rs.sakura.ne.jp
X-Virus-Status: clean

On 2026/05/19 11:04, Jakub Kicinski wrote:
> On Tue, 19 May 2026 10:21:32 +0900 Tetsuo Handa wrote:
>>  net/can/j1939/bus.c        | 2 ++
>>  net/can/j1939/j1939-priv.h | 3 +++
>>  net/can/j1939/main.c       | 8 ++++----
>>  net/can/j1939/transport.c  | 2 ++
> 
> Please follow the address list that get_maintainer produces for you.
> netdev@ is flooded by AI patches already we really don't need more.

scripts/get_maintainer.pl produced the following output.

Robin van der Gracht <robin@protonic.nl> (maintainer:CAN-J1939 NETWORK LAYER)
Oleksij Rempel <o.rempel@pengutronix.de> (maintainer:CAN-J1939 NETWORK LAYER)
kernel@pengutronix.de (reviewer:CAN-J1939 NETWORK LAYER)
Oliver Hartkopp <socketcan@hartkopp.net> (maintainer:CAN NETWORK LAYER)
Marc Kleine-Budde <mkl@pengutronix.de> (maintainer:CAN NETWORK LAYER)
linux-can@vger.kernel.org (open list:CAN-J1939 NETWORK LAYER)
linux-kernel@vger.kernel.org (open list)

Do you mean that I should omit netdev@vger.kernel.org , and use "[PATCH v2]"
so that automated process won't be involved before CAN maintainers send this
patch to netdev@vger.kernel.org ?


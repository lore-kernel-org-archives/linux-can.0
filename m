Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7CC33064D
	for <linux-can@vger.kernel.org>; Tue, 29 Sep 2026 09:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790672886; cv=none; b=hs+cYoFrLPuPPhvPIHWisn8pfMlqHWNy90FHd2onK8iDBo1exCxc8Na2fGLJMjsMIxyiVAJOUS2qziXTUSwk8d+knfCW3eMC7r5tTPgb4TLCWAihL5XcQkHrISe8djrCwIrMaO/5B6YxwyTroiV9u6OaSnOWw3w4r5XmaTgAe64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790672886; c=relaxed/simple;
	bh=OBWrXzQwcic4FCxXI3v24X5lV+giEXd/J0pp4KU9ii4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uju02Ec6VhWt/9r6pcmazqshlsWG6DFTIV6f9nIRCV3UZ+YeaLDmGJoCTidyRIU8Of5/PU/Vzi872ey/bTZUFKta58SZcHQl5KOiv2rHXhCxJS7RjnV/9sWfFxj5ndKZ9AH6gIqgw1uqHddeqqm3CnJUjiqfsn6XKhfbSxXzsEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 68T97iSf093842;
	Tue, 29 Sep 2026 18:07:44 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 68T97ict093839
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 29 Sep 2026 18:07:44 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <4e551134-b290-4294-af20-dc56c92903e1@I-love.SAKURA.ne.jp>
Date: Tue, 29 Sep 2026 18:07:43 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 06/22] can: j1939: j1939_sk_bind(): fix j1939_ecu leak
 when re-bind failed
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org,
        syzbot+e2af46126e0644cbebdd@syzkaller.appspotmail.com,
        Oleksij Rempel <o.rempel@pengutronix.de>
References: <20260928193312.553632-1-mkl@pengutronix.de>
 <20260928193312.553632-7-mkl@pengutronix.de>
 <20260929-private-shellfish-from-mars-caa38b-mkl@pengutronix.de>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20260929-private-shellfish-from-mars-caa38b-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav313.rs.sakura.ne.jp
X-Virus-Status: clean

On 2026/09/29 17:56, Marc Kleine-Budde wrote:
> I've dropped the patch for now, the netdev bots gave the following
> review:
> 
> regards,
> Marc
Yes, please. I'm trying to make an updated patch.

https://sashiko.dev/#/patchset/f982152f-ff51-4d31-a17c-bd0d562c1414%40I-love.SAKURA.ne.jp


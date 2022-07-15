package leanplumapi.userinfo;

import com.intuit.karate.junit5.Karate;

public class UserInfoRunner {

    @Karate.Test
    Karate testUsers() {
        return Karate.run("userinfo").relativeTo(getClass());
    }
}
